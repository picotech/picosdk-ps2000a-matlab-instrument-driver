%% PicoScope 2000 Series (A API) Instrument Driver Oscilloscope Rapid Block Data Capture Example
% This is an example of an instrument control session using a device
% object. The instrument control session comprises all the steps you are
% likely to take when communicating with your instrument.
%       
% These steps are:
%    
% # Create a device object   
% # Connect to the instrument 
% # Configure properties 
% # Invoke functions 
% # Disconnect from the instrument 
%
% To run the instrument control session, type the name of the file,
% PS2000A_ID_Rapid_Block_Plot3D_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_RAPID_BLOCK_PLOT3D_EXAMPLE.M must be on your MATLAB
% PATH. For additional information on setting your MATLAB PATH, type 'help
% addpath' at the MATLAB command prompt.
%
% *Example:*
%     PS2000A_ID_Rapid_Block_Plot3D_Example;
%   
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     capture data in rapid block mode from a PicoScope 2000 Series
%     Oscilloscope using the underlying 'A' API library functions.
%   
% *See also:* <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
%
% *Copyright:* © 2015-2017 Pico Technology Ltd. See LICENSE file for terms.

%% Suggested input test signal
% This example was published using the following test signal:
%
% * Channel A: 4 Vpp Swept sine wave (Start: 10 kHz, Stop: 20 kHz, Sweep type: Up, Increment: 1.5 kHz, Increment Time: 1 ms)

%% Clear command window and close any figures

clc;
close all;

%% Load configuration information

PS2000aConfig;

%% Device connection

% Check if an Instrument session using the device object |ps2000aDeviceObj|
% is still open, and if so, disconnect if the User chooses 'Yes' when prompted.
if (exist('ps2000aDeviceObj', 'var') && ps2000aDeviceObj.isvalid && strcmp(ps2000aDeviceObj.status, 'open'))
    
    openDevice = questionDialog(['Device object ps2000aDeviceObj has an open connection. ' ...
        'Do you wish to close the connection and continue?'], ...
        'Device Object Connection Open');
    
    if (openDevice == PicoConstants.TRUE)
        
        % Close connection to device.
        disconnect(ps2000aDeviceObj);
        delete(ps2000aDeviceObj);
        
    else

        % Exit script if User selects 'No'.
        return;
        
    end
    
end

% Create a device object. 
% The serial number can be specified as a second input parameter.
ps2000aDeviceObj = icdevice('picotech_ps2000a_generic.mdd');

% Connect device object to hardware.
connect(ps2000aDeviceObj);

%% Set channels
% Default driver settings applied to channels are listed below - use
% |ps2000aSetChannel()| to turn channels on or off and set voltage ranges,
% coupling, as well as analog offset.

% In this example, data is only collected on channel A so default settings
% are used and all other channels are switched off.

% Channels       : 1 - 3 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_B - PS2000A_CHANNEL_D)
% Enabled        : 0 (PicoConstants.FALSE)
% Type           : 1 (ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC)
% Range          : 8 (ps2000aEnuminfo.enPS2000ARange.PS2000A_5V)
% Analog Offset  : 0.0 V

[status.setChB] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 1, 0, 1, 8, 0.0);

if (ps2000aDeviceObj.channelCount == PicoConstants.QUAD_SCOPE)
    
    [status.setChC] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 2, 0, 1, 8, 0.0);
    [status.setChD] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 3, 0, 1, 8, 0.0);
    
end

%% Set memory segments
% Configure the number of memory segments and query |ps2000aMemorySegments()|
% to find the maximum number of samples for each segment.

% nSegments : 16

nSegments = 16;
[status.memorySegments, nMaxSamples] = invoke(ps2000aDeviceObj, 'ps2000aMemorySegments', nSegments);

% Set the number of pre- and post-trigger samples to collect. Ensure that
% the total does not exceeed |nMaxSamples| above.

set(ps2000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps2000aDeviceObj, 'numPostTriggerSamples', 512);

%% Verify timebase index and maximum number of samples
% Use the |ps2000aGetTimebase2()| function to query the driver as to the
% suitability of using a particular timebase index and the maximum number
% of samples available in the segment selected then set the |timebase|
% property if required.
%
% To use the fastest sampling interval possible, enable one analog
% channel and turn off all other channels.
%
% Use a while loop to query the function until the status indicates that a
% valid timebase index has been selected. In this example, the timebase
% index of 42 is valid.

% Initial call to ps2000aGetTimebase2() with parameters:
%
% timebase      : 42 (320 ns for a PicoScope 2208A)
% segment index : 0

status.getTimebase2 = PicoStatus.PICO_INVALID_TIMEBASE;
timebaseIndex = 42;

while (status.getTimebase2 == PicoStatus.PICO_INVALID_TIMEBASE)
    
    [status.getTimebase2, timeIntNs, maxSamples] = invoke(ps2000aDeviceObj, ...
                                                    'ps2000aGetTimebase2', timebaseIndex, 0);
    
    if (status.getTimebase2 == PicoStatus.PICO_OK)
       
        break;
        
    else
        
        timebaseIndex = timebaseIndex + 1;
        
    end    
    
end

% Configure the device object's |timebase| property value.
set(ps2000aDeviceObj, 'timebase', timebaseIndex);

%% Set simple trigger
% Set a trigger on channel A, with an auto timeout - the default value for
% trigger delay is used. The trigger will wait for a rising edge through
% the specified threshold unless the timeout occurs first.

% Trigger properties and functions are located in the Instrument
% Driver's Trigger group.

triggerGroupObj = get(ps2000aDeviceObj, 'Trigger');
triggerGroupObj = triggerGroupObj(1);

% Set the |autoTriggerMs| property in order to automatically trigger the
% oscilloscope after 1 second if a trigger event has not occurred. Set to 0
% to wait indefinitely for a trigger event.

set(triggerGroupObj, 'autoTriggerMs', 1000);

% Channel     : 0 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A)
% Threshold   : 500 mV
% Direction   : 2 (ps2000aEnuminfo.enPS2000AThresholdDirection.PS2000A_RISING)

[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 500, 2);

%% Setup rapid block parameters and capture data
% Capture a set of data using rapid block mode and retrieve data values for
% channel A.

% Rapid Block specific properties and functions are located in the
% Instrument Driver's Rapidblock group.

rapidBlockGroupObj = get(ps2000aDeviceObj, 'Rapidblock');
rapidBlockGroupObj = rapidBlockGroupObj(1);

% Set the number of waveforms to captures

% nCaptures : 16

numCaptures = 16;
[status.setNoOfCaptures] = invoke(rapidBlockGroupObj, 'ps2000aSetNoOfCaptures', numCaptures);

% Block specific properties and functions are located in the Instrument
% Driver's Block group.

blockGroupObj = get(ps2000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

%% 
% This example uses the |runBlock()| function in order to collect a block of
% data - if other code needs to be executed while waiting for the device to
% indicate that it is ready, use the |ps2000aRunBlock()| function and poll
% the |ps2000aIsReady()| function until the device indicates that it has
% data available for retrieval.

% Capture the blocks of data:

% segmentIndex : 0 

[status.runBlock, timeIndisposedMs] = invoke(blockGroupObj, 'runBlock', 0);

% Retrieve Rapid Block Data:

downsamplingRatio       = 1;
downsamplingRatioMode   = ps2000aEnuminfo.enPS2000ARatioMode.PS2000A_RATIO_MODE_NONE;

% Provide additional output arguments for the remaining channels e.g. chB
% for Channel B
[numSamples, overflow, chA, ~] = invoke(rapidBlockGroupObj, 'getRapidBlockData', numCaptures, ...
                                    downsamplingRatio, downsamplingRatioMode);

%% Process data
% Plot data values in 3D showing history.
%
% Calculate the time period over which samples were taken for each waveform.
% Use the |timeIntNs| output from the |ps2000aGetTimebase2()| function or
% calculate the sampling interval using the main Programmer's Guide.
% Take into account the downsampling ratio used.

timeNs = double(timeIntNs) * downsamplingRatio * double(0:numSamples - 1);

% Channel A

figure1 = figure('Name','PicoScope 2000 Series (A API) Example - Rapid Block Mode Capture', ...
    'NumberTitle', 'off');

axes1 = axes('Parent', figure1);
view(axes1, [-15 24]);
grid(axes1, 'on');
hold(axes1, 'all');

for i = 1:numCaptures
    
    plot3(timeNs, i * (ones(numSamples, 1)), chA(:, i));
    
end

title(axes1, 'Rapid Block Data Acquisition - Channel A');
xlabel(axes1, 'Time (ns)');
ylabel(axes1, 'Capture');
zlabel(axes1, 'Voltage (mV)');

hold(axes1, 'off');

%% Stop the device

[status.stop] = invoke(ps2000aDeviceObj, 'ps2000aStop');

%% Disconnect device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);

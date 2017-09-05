%% PicoScope 2000 Series (A API) Instrument Driver Mixed Signal Oscilloscope Block Data Capture Example
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
% PS2000A_MSO_ID_MSO_Block_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_MSO_BLOCK_EXAMPLE.M must be on your MATLAB PATH. For
% additional information on setting your MATLAB PATH, type 'help addpath'
% at the MATLAB command prompt.
%
% *Example:*
%     PS2000A_ID_MSO_Block_Example;
%
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     capture a block of data from a PicoScope 2000 Series Mixed Signal
%     Oscilloscope using the underlying 'A' API library functions.
%
% *See also:* <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
% 
% *Copyright:* © 2015-2017 Pico Technology Ltd. See LICENSE file for terms.

%% Suggested Input Test Signals
% This example was published using the following test signals:
%
% * Channel A: 4 Vpp, 4 kHz Sine wave
% * Channel B: 2 Vpp, 2 kHz Square wave
% * PORT0    : 4 Vpp, 5 kHz Square wave (applied to all channels)

%% Clear Command Window and Close any Figures

clc;
close all;

%% Load Configuration Information

PS2000aConfig;

%% Device Connection

% Check if an Instrument session using the device object 'ps2000aDeviceObj'
% is still open, and if so, disconnect if the User chooses 'Yes' when prompted.
if (exist('ps2000aDeviceObj', 'var') && ps2000aDeviceObj.isvalid && strcmp(ps2000aDeviceObj.status, 'open'))
    
    openDevice = questionDialog(['Device object ps2000aDeviceObj has an open connection. ' ...
        'Do you wish to close the connection and continue?'], ...
        'Device Object Connection Open');
    
    if (openDevice == PicoConstants.TRUE)
        
        % Close connection to device
        disconnect(ps2000aDeviceObj);
        delete(ps2000aDeviceObj);
        
    else

        % Exit script if User selects 'No'
        return;
        
    end
    
end

% Create a device object. 
% The serial number can be specified as a second input parameter.
ps2000aDeviceObj = icdevice('picotech_ps2000a_generic.mdd', '');

% Connect device object to hardware.
connect(ps2000aDeviceObj)

%% Set Analog Channels and Digital Ports
% Default driver settings applied to analog and digital channels are
% listed below - use the Instrument Driver's |ps2000aSetChannel()| function
% to turn analog channels on or off and set voltage ranges, coupling, as
% well as analog offset.
%
% In this example, data is collected on channels A and B using default
% settings and also on the Digital Port 0 channels (D0 - D7) while Digital
% Port 1 (D8 - D15) is switched off.

% Channels       : 0 - 1 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A & PS2000A_CHANNEL_B)
% Enabled        : 1 (On - PicoConstants.TRUE)
% Type           : 1 (ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC)
% Range          : 8 (ps2000aEnuminfo.enPS2000ARange.PS2000A_5V)
% Analog Offset  : 0.0 V

%% 
% Use the |ps2000aSetDigitalPort()| function to enable/disable digital ports
% and set the logic level threshold. This function is located in the
% Instrument Driver's Digital Group. Enabling a digital port will enable
% all channels on that port, while setting the enabled parameter to 0 will
% turn off all digital channels on that port.

digitalObj = get(ps2000aDeviceObj, 'Digital');

% Digital Port  : 128 (ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT0)
% Enabled       : 1 (On - PicoConstants.TRUE)
% Logic Level   : 1.5 V

status.setDPort0 = invoke(digitalObj, 'ps2000aSetDigitalPort', ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT0, 1, 1.5);

% Digital Port  : 129 (ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT1)
% Enabled       : 0 (Off - PicoConstants.FALSE)
% Logic Level   : 0 V

status.setDPort1 = invoke(digitalObj, 'ps2000aSetDigitalPort', ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT1, 0, 0);

%% Verify Timebase Index and Maximum Number of Samples
% Use the |ps2000aGetTimebase2()| function to query the driver as to the
% suitability of using a particular timebase index and the maximum number
% of samples available in the segment selected, then set the |timebase|
% property if required.
%
% To use the fastest sampling interval possible, enable one analog
% channel and turn off all other channels.
%
% Use a while loop to query the function until the status indicates that a
% valid timebase index has been selected. In this example, the timebase
% index of 10 is valid.

% Initial call to ps2000aGetTimebase2() with parameters:
%
% timebase      : 10 (100 ns for a PicoScope 2205 MSO)
% segment index : 0

status.getTimebase2 = PicoStatus.PICO_INVALID_TIMEBASE;
timebaseIndex = 10;

while (status.getTimebase2 == PicoStatus.PICO_INVALID_TIMEBASE)
    
    [status.getTimebase2, timeIntervalNanoseconds, maxSamples] = invoke(ps2000aDeviceObj, 'ps2000aGetTimebase2', timebaseIndex, 0);
    
    if (status.getTimebase2 == PicoStatus.PICO_OK)
       
        break;
        
    else
        
        timebaseIndex = timebaseIndex + 1;
        
    end    
    
end

fprintf('Timebase index: %d, sampling interval: %d ns\n', timebaseIndex, timeIntervalNanoseconds);

% Configure the device object's |timebase| property value.
set(ps2000aDeviceObj, 'timebase', timebaseIndex);

%% Set Simple Trigger
% Set a trigger on channel A, with an auto timeout - the default value for
% delay is used.

% Trigger properties and functions are located in the Instrument
% Driver's Trigger group.

triggerGroupObj = get(ps2000aDeviceObj, 'Trigger');
triggerGroupObj = triggerGroupObj(1);

% Set the |autoTriggerMs| property in order to automatically trigger the
% oscilloscope after 1 second if a trigger event has not occurred. Set to 0
% to wait indefinitely for a trigger event.

set(triggerGroupObj, 'autoTriggerMs', 1000);

% Channel     : 0 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A)
% Threshold   : 1000 mV
% Direction   : 2 (ps2000aEnuminfo.enPS2000AThresholdDirection.PS2000A_RISING)

[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 1000, 2);

%% Set Block Parameters and Capture Data
% Capture a block of data and retrieve data values for channels A, B, and
% D0 to D7.

% Block data acquisition properties and functions are located in the 
% Instrument Driver's Block group.

blockGroupObj = get(ps2000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

% Set pre-trigger and post-trigger samples as required - the total of this
% should not exceed the value of |maxSamples| returned from the call to
% |ps2000aGetTimebase2()|. The default of 0 pre-trigger and 8192 post-trigger
% samples is used in this example.

% set(ps2000aDeviceObj, 'numPreTriggerSamples', 0);
% set(ps2000aDeviceObj, 'numPostTriggerSamples', 16384);

%%
% This example uses the |runBlock()| function in order to collect a block of
% data - if other code needs to be executed while waiting for the device to
% indicate that it is ready, use the |ps2000aRunBlock()| function and poll
% the |ps2000aIsReady()| function.

% Capture a block of data:
%
% segment index: 0 (The buffer memory is not segmented in this example)

[status.runBlock] = invoke(blockGroupObj, 'runBlock', 0);

% Retrieve data values:

startIndex              = 0;
segmentIndex            = 0;
downsamplingRatio       = 1;
downsamplingRatioMode   = ps2000aEnuminfo.enPS2000ARatioMode.PS2000A_RATIO_MODE_NONE;

% Provide additional output arguments for the remaining channels e.g.
% dPort1 for Digital PORT1.
[numSamples, overflow, chA, chB, ~, ~, dPort0, ~] = invoke(blockGroupObj, 'getBlockData', startIndex, ...
                                                        segmentIndex, downsamplingRatio, downsamplingRatioMode);

%% Process Data
% In this example the data values returned from the device are displayed in
% plots in with separate figures for analog and digital data.
%
% Calculate sampling interval (nanoseconds) and convert to milliseconds.
% Use the |timeIntervalNanoSeconds| output from the |ps2000aGetTimebase2()|
% function or calculate it using the main Programmer's Guide.
% Take into account the downsampling ratio used.

timeNs = double(timeIntervalNanoseconds) * downsamplingRatio * double(0:numSamples - 1);
timeMs = timeNs / 1e6;

%%
% *Analog Data*

scrsz = get(groot,'ScreenSize');

analogFigure = figure('Name','PicoScope 2000 Series (A API) - MSO Block Mode Capture', ...
    'NumberTitle', 'off', 'Position', [1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);

movegui(analogFigure, 'west');

hold on;

% Channel A and B
plot(timeMs, chA, timeMs, chB);
title('Analog Channel Data');
xlabel('Time (ms)');
ylabel('Voltage (mV)');
legend('Channel A', 'Channel B');
grid on;

hold off;

%% 
% *Digital Data*

digitalFigure = figure('Name','PicoScope 2000 Series (A API) Example - MSO Block Mode Capture', ...
    'NumberTitle', 'off', 'Position', [scrsz(3)/2 + 1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);

movegui(digitalFigure, 'east');

disp('Converting digital integer data to binary...');

% Create 2D array to hold binary data values for each channel.
dPort0Binary = zeros(numSamples, 8);

% Retrieve the bit values from the lower 8 bits of the 16-bit values
% returned for dPort0 - each bit corresponds to a digital channel. Channel
% D0 data will be in column 8 and D7 data will be in column 1.
for sample = 1:numSamples

    dPort0Binary(sample, :) = bitget(dPort0(sample), 8:-1:1, 'int16');
    
end

hold on;

% Specify colours to use for the plots - the colour to use will be selected
% according to the digital channel.
digiPlotColours = ['m', 'b', 'r', 'g'];

% Display digital data in a 4 x 2 grid
for i = 1:8
    
    subplot(4, 2, i); 
    plot(timeMs, dPort0Binary(:, (8 - (i - 1))), digiPlotColours(rem(i, length(digiPlotColours)) + 1));
    title(strcat('Digital Channel D', num2str(i - 1)));
    xlabel('Time (ms)');
    ylabel('Logic Level');
    axis([-inf, inf, -0.5, 1.5])
    grid on;
    
end

hold off;

%% Stop the Device

[status.stop] = invoke(ps2000aDeviceObj, 'ps2000aStop');

%% Disconnect Device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);

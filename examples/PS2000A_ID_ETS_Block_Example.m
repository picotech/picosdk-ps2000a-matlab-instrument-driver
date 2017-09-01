%% PicoScope 2000 Series (A API) Instrument Driver Oscilloscope ETS Block Data Capture Example
% This is an example of an instrument control session using a device 
% object. The instrument control session comprises all the steps you 
% are likely to take when communicating with your instrument. 
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
% PS2000A_ID_ETS_Block_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_ETS_BLOCK_EXAMPLE.M must be on your MATLAB PATH. For
% additional information on setting your MATLAB PATH, type 'help addpath'
% at the MATLAB command prompt.
%
% *Example:*
%     PS2000A_ID_ETS_Block_Example;
%
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     capture a block of data using Equivalent Time Sampling from a
%     PicoScope 2000 Series Oscilloscope using the underlying 'A' API
%     library functions.
%
% *See also:* <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
% 
% *Copyright:* © 2016-2017 Pico Technology Ltd. See LICENSE file for terms.

%% Suggested Input Test Signals
% This example was published using the following test signals:
%
% * Channel A: 4 Vpp, 1 MHz sine wave

%% Clear Command Window and Close any Figures

clc;
close all;

%% Load Configuration Information

PS2000aConfig

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

        % Exit script if User 
        return;
        
    end
    
end

% Create a device object. 
% The serial number can be specified as a second input parameter.
ps2000aDeviceObj = icdevice('picotech_ps2000a_generic.mdd', '');

% Connect device object to hardware.
connect(ps2000aDeviceObj)

%% Set Channels
% Default driver settings applied to channels are listed below - use the
% Instrument Driver's |ps2000aSetChannel| function to turn channels on or
% off and set voltage ranges, coupling, as well as analog offset.

% In this example, data is collected on channel A. If it is a
% 4-channel model, channels C and D will be switched off.

% Channel        : 0 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A)
% Enabled        : 1 (PicoConstants.TRUE)
% Type           : 1 (ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC)
% Range          : 8 (ps2000aEnuminfo.enPS2000ARange.PS2000A_5V)
% Analog Offset  : 0.0 V

% Channels       : 1 - 3 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_B, PS2000A_CHANNEL_C & PS2000A_CHANNEL_D)
% Enabled        : 0 (PicoConstants.FALSE)
% Type           : 1 (ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC)
% Range          : 8 (ps2000aEnuminfo.enPS2000ARange.PS2000A_5V)
% Analog Offset  : 0.0 V

[status.setChB] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 1, 0, 1, 8, 0.0);

if (ps2000aDeviceObj.channelCount == PicoConstants.QUAD_SCOPE)
    
    [status.setChC] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 2, 0, 1, 8, 0.0);
    [status.setChD] = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', 3, 0, 1, 8, 0.0);
    
end

%% Set ETS Mode Parameters
% Set Equivalent Time Sampling Parameters
% The underlying driver will return the sampling interval to be used (in
% picoseconds).

% Block data acquisition properties and functions are located in the 
% Instrument Driver's Block group.

blockGroupObj = get(ps2000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

mode            = ps2000aEnuminfo.enPS2000AEtsMode.PS2000A_ETS_FAST;
etsCycles       = 20;
etsInterleave   = 4;

[status.setEts, sampleTimePicoSeconds] = invoke(blockGroupObj, 'ps2000aSetEts', mode, etsCycles, etsInterleave);

fprintf('ETS sampling interval: %d picoseconds.\n', sampleTimePicoSeconds);

%% Verify Maximum Samples
% Driver default timebase index used for calling the |ps2000aGetTimebase2|
% function to query the driver as to the maximum number of samples
% available in the buffer memory. The sample time for ETS mode is returned
% in the call to |ps2000aSetEts| above.
%
% To use the fastest sampling interval possible, set one analog channel
% and turn off all other channels.

% timebase     : 64 (default)
% segment index: 0

timebaseIndex = get(ps2000aDeviceObj, 'timebase');
    
[status.getTimebase2, ~, maxSamples] = invoke(ps2000aDeviceObj, ...
                                        'ps2000aGetTimebase2', timebaseIndex, 0);
   
%% Set Simple Trigger
% Set a trigger on channel A, with an auto timeout - the default value for
% delay is used.

% Trigger properties and functions are located in the Instrument
% Driver's Trigger group.

triggerGroupObj = get(ps2000aDeviceObj, 'Trigger');
triggerGroupObj = triggerGroupObj(1);

%%
% Set the |autoTriggerMs| property in order to automatically trigger the
% oscilloscope after 1 second if a trigger event has not occurred. Set to 0
% to wait indefinitely for a trigger event.

set(triggerGroupObj, 'autoTriggerMs', 1000);

% Channel     : 0 (ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A)
% Threshold   : 1000 mV
% Direction   : 2 (ps2000aEnuminfo.enPS2000AThresholdDirection.PS2000A_RISING)

[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 1000, 2);

%% Set Block Parameters and Capture Data
% Capture a block of data and retrieve data values for channel A.

% Block data acquisition properties and functions are located in the 
% Instrument Driver's Block group.

blockGroupObj = get(ps2000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

% Set pre-trigger and post-trigger samples as required - the total of this
% should not exceed the value of |maxSamples| returned from the call to
% ps2000aGetTimebase2. 

set(ps2000aDeviceObj, 'numPreTriggerSamples', 8000);
set(ps2000aDeviceObj, 'numPostTriggerSamples', 8000);

%%
% This example uses the |runBlock| function in order to collect a block of
% data - if other code needs to be executed while waiting for the device to
% indicate that it is ready, use the |ps2000aRunBlock| function and poll
% the |ps2000aIsReady| function.

% Capture a block of data:
%
% segment index: 0 (The buffer memory is not segmented in this example)

[status.runBlock] = invoke(blockGroupObj, 'runBlock', 0);

% Retrieve data values:

startIndex              = 0;
segmentIndex            = 0;
downsamplingRatio       = 1;
downsamplingRatioMode   = ps2000aEnuminfo.enPS2000ARatioMode.PS2000A_RATIO_MODE_NONE;

[numSamples, overflow, etsTimes, chA, ~, ~, ~] = invoke(blockGroupObj, 'getEtsBlockData', startIndex, ...
                                                            segmentIndex, downsamplingRatio, downsamplingRatioMode);

%% Process Data
% In this example the data values returned from the device are displayed in
% plots in a Figure.

figure1 = figure('Name','PicoScope 2000 Series (A API) Example - ETS Block Mode Capture', ...
    'NumberTitle', 'off');

% Channel A
plot(etsTimes, chA, 'b');
title('Channel A');
xlabel('Time (fs)');
ylabel('Voltage (mV)');
grid on;

%% Stop the Device

[status.stop] = invoke(ps2000aDeviceObj, 'ps2000aStop');

%% Turn off ETS Mode
% If another operation is required that does not require Equivalent Time
% Sampling of data, turn ETS mode off.

mode            = ps2000aEnuminfo.enPS2000AEtsMode.PS2000A_ETS_OFF;
etsCycles       = 20;
etsInterleave   = 4;

[status.setEts, sampleTimePicoSeconds] = invoke(blockGroupObj, 'ps2000aSetEts', mode, etsCycles, etsInterleave);

%% Disconnect Device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);

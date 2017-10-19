%% PicoScope 2000 Series (A API) Instrument Driver Oscilloscope Block Data Capture with FFT Example
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
% PS2000A_ID_Block_FFT_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_BLOCK_FFT_EXAMPLE.M must be on your MATLAB PATH. For
% additional information on setting your MATLAB PATH, type 'help addpath'
% at the MATLAB command prompt.
%
% *Example:*
%     PS2000A_ID_Block_FFT_Example;
%
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     capture a block of data from a PicoScope 2000 Series Oscilloscope
%     using the underlying 'A' API library functions and calculate a Fast
%     Fourier Transform (FFT) on the data collected.
%
% *See also:* <matlab:doc('fft') |fft|> | <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
% 
% *Copyright:* © 2015-2017 Pico Technology Ltd. See LICENSE file for terms.

%% Suggested input test signal
% This example was published using the following test signal:
%
% * Channel A: 4 Vpp, 1 kHz square wave

%% Clear command window and close any figures

clc;
close all;

%% Load configuration information

PS2000aConfig

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
ps2000aDeviceObj = icdevice('picotech_ps2000a_generic.mdd', '');

% Connect device object to hardware.
connect(ps2000aDeviceObj)

%% Set channels
% Default driver settings applied to channels are listed below - use the
% Instrument Driver's |ps2000aSetChannel()| function to turn channels on or
% off and set voltage ranges, coupling, as well as analog offset.

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

%% Verify timebase index and maximum number of samples
% Use the |ps2000aGetTimebase2()| function to query the driver as to the
% suitability of using a particular timebase index and the maximum number
% of samples available in the segment selected, then set the |timebase|
% property if required.
%
% To use the fastest sampling interval possible, enable one analog
% channel and turn off all other channels.
%
% Use a while loop to query the function until the status indicates that a
% valid timebase index has been selected. For the purposes of this example,
% the signal is sampled at five times its frequency so a timebase index of 
% 6252 is used.

% Initial call to ps2000aGetTimebase2() with parameters:
%
% timebase      : 6252
% segment index : 0

status.getTimebase2 = PicoStatus.PICO_INVALID_TIMEBASE;
timebaseIndex = 6252;

while (status.getTimebase2 == PicoStatus.PICO_INVALID_TIMEBASE)
    
    [status.getTimebase2, timeIntervalNanoseconds, maxSamples] = invoke(ps2000aDeviceObj, ...
                                                                    'ps2000aGetTimebase2', timebaseIndex, 0);
    
    if (status.getTimebase2 == PicoStatus.PICO_OK)
       
        break;
        
    else
        
        timebaseIndex = timebaseIndex + 1;
        
    end    
    
end

fprintf('Timebase index: %d, sampling interval: %d ns\n', timebaseIndex, timeIntervalNanoseconds);

% Configure the device |timebase| property value.
set(ps2000aDeviceObj, 'timebase', timebaseIndex);

%% Set simple trigger
% Set a trigger on Channel A, with an auto timeout - the default value for
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
% Threshold   : 1000 (mV)
% Direction   : 2 (ps2000aEnuminfo.enPS2000AThresholdDirection.PS2000A_RISING)

[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 1000, 2);

%% Set block parameters and capture data
% Capture a block of data and retrieve data values for channels A and B.

% Block data acquisition properties and functions are located in the 
% Instrument Driver's Block group.

blockGroupObj = get(ps2000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

% Set pre-trigger and post-trigger samples as required - the total of this
% should not exceed the value of |maxSamples| returned from the call to
% |ps2000aGetTimebase2()|. The example below shows the number of pre-trigger
% and post trigger samples being adjusted.

set(ps2000aDeviceObj, 'numPreTriggerSamples', 8192);
set(ps2000aDeviceObj, 'numPostTriggerSamples', 16384);

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

% Provide additional output arguments for other channels e.g. chC for
% channel C if using a 4-channel PicoScope.
[numSamples, overflow, chA, ~] = invoke(blockGroupObj, 'getBlockData', startIndex, segmentIndex, ...
                                            downsamplingRatio, downsamplingRatioMode);

%% Process data
% Plot data values, calculate and plot FFT.

figure1 = figure('Name','PicoScope 2000 Series (A API) Example - Block Mode Capture with FFT', ...
    'NumberTitle','off');

% Calculate sampling interval (nanoseconds) and convert to milliseconds.
% Use the |timeIntervalNanoSeconds| output from the |ps2000aGetTimebase2()|
% function or calculate it using the main Programmer's Guide.
% Take into account the downsampling ratio used.

timeNs = double(timeIntervalNanoseconds) * downsamplingRatio * double(0:numSamples - 1);
timeMs = timeNs / 1e6;

% Channel A
chAAxes = subplot(2,1,1); 
plot(chAAxes, timeMs, chA);
ylim(chAAxes, [-2500 2500]); % Adjust vertical axis for signal

title(chAAxes, 'Block Data Acquisition');
xlabel(chAAxes, 'Time (ms)');
ylabel(chAAxes, 'Voltage (mV)');
grid(chAAxes, 'on');
legend(chAAxes, 'Channel A');

% Calculate FFT of Channel A and plot - based on <matlab:doc('fft') fft documentation>.
L = length(chA);
n = 2 ^ nextpow2(L); % Next power of 2 from length of chA

Y = fft(chA, n);

% Obtain the single-sided spectrum of the signal.
P2 = abs(Y/n);
P1 = P2(1:n/2+1);
P1(2:end-1) = 2 * P1(2:end-1);

Fs = 1 / (timeIntervalNanoseconds * 1e-9);
f = 0:(Fs/n):(Fs/2 - Fs/n);

chAFFTAxes = subplot(2,1,2);
plot(chAFFTAxes, f, P1(1:n/2)); 

title(chAFFTAxes, 'Single-Sided Amplitude Spectrum of y(t)');
xlabel(chAFFTAxes, 'Frequency (Hz)');
ylabel(chAFFTAxes, '|Y(f)|');
grid(chAFFTAxes, 'on');

%% Stop the device

[status.stop] = invoke(ps2000aDeviceObj, 'ps2000aStop');

%% Disconnect device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);
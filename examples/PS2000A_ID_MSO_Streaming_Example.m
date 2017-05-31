%% PicoScope 2000 Series (A API) Instrument Driver Mixed Signal Oscilloscope Streaming Data Capture Example
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
% PS2000A_ID_MSO_Streaming_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_MSO_STREAMING_EXAMPLE.M must be on your MATLAB PATH. For
% additional information on setting your MATLAB PATH, type 'help addpath'
% at the MATLAB command prompt.
%
% *Example:*
%     PS2000A_ID_MSO_Streaming_Example;
%
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     capture data in streaming mode from a PicoScope 2000 Series Mixed
%     Signal Oscilloscope using the underlying 'A' API library functions.
%
% *Note:* Not all device and group object functions used in this example
% are compatible with the Test and Measurement Tool.
%
% *See also:* <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
%
% *Copyright:* © 2015 - 2017 Pico Technology Ltd. See LICENSE file for terms.

%% Suggested Input Test Signals
% This example was published using the following test signals:
%
% * Channel A: 3 Vpp, 1 Hz Sine wave
% * Channel B: 2 Vpp, 4 Hz Square wave 
% * PORT0    : 4 Vpp, 10 Hz Square wave

%% Clear Command Window and Close any Figures

clc;
close all;

%% Load Configuration Information

PS2000aConfig;

%% Parameter Definitions
% Define any parameters that might be required throughout the script.

channelA = ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_A;
channelB = ps2000aEnuminfo.enPS2000AChannel.PS2000A_CHANNEL_B;
dPort0   = ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT0;

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
ps2000aDeviceObj = icdevice('picotech_ps2000a_generic', '');

% Connect device
connect(ps2000aDeviceObj);

%% Display Unit Information From Shared Library

fprintf('Unit Information:\n\n');

[infoStatus, unitInfo] = invoke(ps2000aDeviceObj, 'getUnitInfo');

disp(unitInfo);

%% Set Analog Channels and Digital Ports
% All channels are enabled by default. Analog channel settings are
% changed as shown below.

% Channel A
channelSettings(1).enabled          = PicoConstants.TRUE;
channelSettings(1).coupling         = ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC;
channelSettings(1).range            = ps2000aEnuminfo.enPS2000ARange.PS2000A_2V;
channelSettings(1).analogueOffset   = 0.0; % V

channelARangeMV = PicoConstants.SCOPE_INPUT_RANGES(channelSettings(1).range + 1);

% Channel B
channelSettings(2).enabled          = PicoConstants.TRUE;
channelSettings(2).coupling         = ps2000aEnuminfo.enPS2000ACoupling.PS2000A_DC;
channelSettings(2).range            = ps2000aEnuminfo.enPS2000ARange.PS2000A_2V;
channelSettings(2).analogueOffset   = 0.0; % V

channelBRangeMV = PicoConstants.SCOPE_INPUT_RANGES(channelSettings(2).range + 1);

% Keep the status values returned from the driver.
numChannels = get(ps2000aDeviceObj, 'channelCount');

for ch = 1:numChannels
    
    status.setChannelStatus(ch) = invoke(ps2000aDeviceObj, 'ps2000aSetChannel', ...
        (ch - 1), channelSettings(ch).enabled, ...
        channelSettings(ch).coupling, channelSettings(ch).range, ...
        channelSettings(ch).analogueOffset);
    
end

% Obtain the maximum Analog Digital Converter (ADC) count value from the
% driver - this is used for scaling analog channel values returned from
% the driver when data is collected.
maxADCCount = double(get(ps2000aDeviceObj, 'maxADCValue'));

%% 
% Use the |ps2000aSetDigitalPort| function to enable/disable digital ports
% and set the logic level threshold. This function is located in the
% Instrument Driver's Digital Group. Enabling a digital port will enable
% all channels on that port, while setting the enabled parameter to 0 will
% turn off all digital channels on that port.

digitalObj = get(ps2000aDeviceObj,'Digital');

% Digital Port  : 128 (ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT0)
% Enabled       : 1 (On - PicoConstants.TRUE)
% Logic Level   : 1.5 V

invoke(digitalObj, 'ps2000aSetDigitalPort', ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT0, 1, 1.5);

% Digital Port  : 129 (ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT1)
% Enabled       : 0 (Off - PicoConstants.FALSE)
% Logic Level   : 0 V

invoke(digitalObj, 'ps2000aSetDigitalPort', ps2000aEnuminfo.enPS2000ADigitalPort.PS2000A_DIGITAL_PORT1, 0, 0);

%% Trigger Setup
% Turn off trigger.
%
% If a trigger is set and the autoStop property in the driver is set to
% '1', the device will stop collecting data once the number of post trigger
% samples have been collected.

% Trigger properties and functions are located in the Instrument Driver's
% Trigger group.

triggerGroupObj = get(ps2000aDeviceObj, 'Trigger');
triggerGroupObj = triggerGroupObj(1);

[status.setTriggerOff] = invoke(triggerGroupObj, 'setTriggerOff');

%% Set Data Buffers
% Data buffers for Channels A and B as well as Digital PORT0 - buffers
% should be set with the driver, and these MUST be passed with application
% buffers to the wrapper driver in order to ensure data is correctly
% copied.

overviewBufferSize  = 250000; % Size of the buffer to collect data from the driver.
segmentIndex        = 0;
ratioMode           = ps2000aEnuminfo.enPS2000ARatioMode.PS2000A_RATIO_MODE_NONE;

% Buffers to be passed to the driver.
pDriverBufferChA    = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));
pDriverBufferChB    = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));
pDriverBufferDPort0 = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));

[status.setDataBufferChA] = invoke(ps2000aDeviceObj, 'ps2000aSetDataBuffer', ...
                                channelA, pDriverBufferChA, overviewBufferSize, segmentIndex, ratioMode);

[status.setDataBufferChB] = invoke(ps2000aDeviceObj, 'ps2000aSetDataBuffer', ...
                                channelB, pDriverBufferChB, overviewBufferSize, segmentIndex, ratioMode);

status.setDataBufferPortD0 = invoke(ps2000aDeviceObj, 'ps2000aSetDataBuffer', ...
                                dPort0, pDriverBufferDPort0, overviewBufferSize, segmentIndex, ratioMode);

% Application Buffers - these are for temporarily copying data from the driver.
pAppBufferChA       = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));
pAppBufferChB       = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));
pAppBufferDPort0    = libpointer('int16Ptr', zeros(overviewBufferSize, 1, 'int16'));

% Streaming properties and functions are located in the Instrument
% Driver's Streaming group.

streamingGroupObj = get(ps2000aDeviceObj, 'Streaming');
streamingGroupObj = streamingGroupObj(1);

% Register application buffer and driver buffers (with the wrapper library).

[status.setAppAndDriverBuffersA] = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelA, ...
                                    pAppBufferChA, pDriverBufferChA, overviewBufferSize);

[status.setAppAndDriverBuffersB] = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelB, ...
                                    pAppBufferChB, pDriverBufferChB, overviewBufferSize);

% The wrapper uses a zero-based enumeration to identify the digital port
wrapperDPort0 = ps2000aWrapEnuminfo.enPS2000AWrapDigitalPortIndex.PS2000A_WRAP_DIGITAL_PORT0;                                
                                
[status.setAppAndDriverDPort0] = invoke(streamingGroupObj, 'setAppAndDriverDigiBuffers', wrapperDPort0, ...
                                    pAppBufferDPort0, pDriverBufferDPort0, overviewBufferSize);

%% Start Streaming and Collect Data
% Use default value for streaming interval which is 1e-6 for 1MS/s. Collect
% data for 1 second with auto stop - maximum array size will depend on PC's
% resources - type <matlab:doc('memory') |memory|> at the MATLAB command
% prompt for further information.

% To change the sample interval set the streamingInterval property of the
% Streaming group object. The call to the |ps2000aRunStreaming| function
% will output the actual sampling interval used by the driver.

% For 200kS/s, specify 5us
% set(streamingGroupObj, 'streamingInterval', 5e-6);

% For 10MS/s, specify 100ns
% set(streamingGroupObj, 'streamingInterval', 100e-9);

% Set the number of pre- and post-trigger samples
% If no trigger is set 'numPreTriggerSamples' is ignored.
set(ps2000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps2000aDeviceObj, 'numPostTriggerSamples', 2000000);

% The autoStop parameter can be set to false (0) to allow for continuous
% data collection.
% set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);

% Set other streaming parameters:
downSampleRatio     = 1;
downSampleRatioMode = ps2000aEnuminfo.enPS2000ARatioMode.PS2000A_RATIO_MODE_NONE;

% Defined buffers to store data collected from the channels. If capturing
% data without using the autoStop flag, or if using a trigger with the
% autoStop flag, allocate sufficient space (1.5 times the sum of the number of
% pre-trigger and post-trigger samples is shown below) to allow for
% additional pre-trigger data. Pre-allocating the array is more efficient
% than using <matlab:doc('vertcat') |vertcat|> to combine data.

maxSamples = get(ps2000aDeviceObj, 'numPreTriggerSamples') + ...
                get(ps2000aDeviceObj, 'numPostTriggerSamples');

% Take into account the downSamplesRatioMode - required if collecting data
% without a trigger and using the autoStop flag.
% finalBufferLength = round(1.5 * maxSamples / downSampleRatio);

pBufferChAFinal     = libpointer('int16Ptr', zeros(maxSamples, 1, 'int16'));
pBufferChBFinal     = libpointer('int16Ptr', zeros(maxSamples, 1, 'int16'));
pBufferDPort0Final  = libpointer('int16Ptr', zeros(maxSamples, 1, 'int16'));

% Prompt User to indicate if they wish to plot live streaming data.
plotLiveData = questionDialog('Plot live streaming data?', 'Streaming Data Plot');

if (plotLiveData == PicoConstants.TRUE)
   
    disp('Live streaming data collection with second plot on completion.');
    
else
    
    disp('Streaming data plot on completion.');
    
end

% Start streaming data collection.
[status.runStreaming, actualSampleInterval, sampleIntervalTimeUnitsStr] = ...
    invoke(streamingGroupObj, 'ps2000aRunStreaming', downSampleRatio, ...
    downSampleRatioMode, overviewBufferSize);

disp('Streaming data...');
fprintf('Click the STOP button to stop capture or wait for auto stop if enabled.\n\n')

% Variables to be used when collecting the data:

hasAutoStopped      = PicoConstants.FALSE;
newSamples          = 0; % Number of new samples returned from the driver.
previousTotal       = 0; % The previous total number of samples.
totalSamples        = 0; % Total samples captured by the device.
startIndex          = 0; % Start index of data in the buffer returned.
hasTriggered        = 0; % To indicate if trigger has occurred.
triggeredAtIndex    = 0; % The index in the overall buffer where the trigger occurred.

status.getStreamingLatestValues = PicoStatus.PICO_OK; % OK

% Display a 'Stop' button.
[stopFig.h, stopFig.h] = stopButton();

flag = 1; % Use flag variable to indicate if stop button has been clicked (0)
setappdata(gcf, 'run', flag);

% Plot Properties - these are for displaying data as it is collected.

if (plotLiveData == PicoConstants.TRUE)
    
    % Plot on a single figure
    figure1 = figure('Name', 'PicoScope 2000 Series (A API) Example - MSO Streaming Data Capture', 'NumberTitle', 'off');

    analogueAxes = subplot(2, 1, 1);
    digitalAxes = subplot(2, 1, 2);

    % Estimate x-axis limit to try and avoid using too much CPU resources
    % when drawing - use max voltage range selected if plotting multiple
    % channels on the same graph.
    xlim(analogueAxes, [0 (actualSampleInterval * maxSamples)]);
    xlim(digitalAxes, [0 (actualSampleInterval * maxSamples)]);

    yRange = channelARangeMV + 0.5;
    ylim(analogueAxes,[(-1 * yRange) yRange]);
    
    hold(analogueAxes,'on');
    hold(digitalAxes, 'on');

    grid(analogueAxes, 'on');
    grid(digitalAxes, 'on');

    title(analogueAxes, 'Analog Channel Data Acquisition');
    title(digitalAxes, 'Digital Channel Data Acquisition');
    xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')'); %TODO: Update for microseonds
    
    xlabel(analogueAxes, xLabelStr);
    ylabel(analogueAxes, 'Voltage (mV)');
    
    xlabel(digitalAxes, xLabelStr);
    ylabel(digitalAxes, 'Level (Counts)');

end

% Get data values as long as power status has not changed (check for STOP button push inside loop)
while (hasAutoStopped == PicoConstants.FALSE && status.getStreamingLatestValues == PicoStatus.PICO_OK)
    
    ready = PicoConstants.FALSE;
    
    while (ready == PicoConstants.FALSE)
        
        status.getStreamingLatestValues = invoke(streamingGroupObj, 'getStreamingLatestValues');
        
        ready = invoke(streamingGroupObj, 'isReady');
        
        % Give option to abort from here.
        flag = getappdata(gcf, 'run');
        drawnow;
        
        if (flag == 0)
            
            disp('STOP button clicked - aborting data collection.')
            break;
            
        end
        
        drawnow;
        
    end
    
    % Check for data
    [newSamples, startIndex] = invoke(streamingGroupObj, 'availableData');
    
    if (newSamples > 0)
        
        % Check if the scope has triggered.
        [triggered, triggeredAt] = invoke(streamingGroupObj, 'isTriggerReady');
        
        if (triggered == PicoConstants.TRUE)
            
            % Adjust trigger position as MATLAB does not use zero-based
            % indexing
            bufferTriggerPosition = triggeredAt + 1;
            
            fprintf('Triggered - index in buffer: %d\n', bufferTriggerPosition);
            
            hasTriggered = triggered;
            
            % Set the total number of samples at which the device
            % triggered.
            triggeredAtIndex = totalSamples + bufferTriggerPosition;
            
        end
        
        previousTotal   = totalSamples;
        totalSamples    = totalSamples + newSamples;
        
        % Printing to console can slow down acquisition - use for
        % demonstration.
        fprintf('Collected %d samples, startIndex: %d total: %d.\n', newSamples, startIndex, totalSamples);
        
        % Position indices of data in buffer(s).
        firstValuePosn  = startIndex + 1;
        lastValuePosn   = startIndex + newSamples;
        
        % Convert analog data values to millivolts from the application
        % buffer(s).
        bufferChAmV     = adc2mv(pAppBufferChA.Value(firstValuePosn:lastValuePosn), channelARangeMV, maxADCCount);
        bufferChBmV     = adc2mv(pAppBufferChB.Value(firstValuePosn:lastValuePosn), channelBRangeMV, maxADCCount);
        
        bufferDPort0    = pAppBufferDPort0.Value(firstValuePosn:lastValuePosn);
        
        % Process collected data further if required - this example plots
        % the data if the User has selected 'Yes' at the prompt.
        
        % Copy data into final buffers
        pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
        pBufferChBFinal.Value(previousTotal + 1:totalSamples) = bufferChBmV;
        pBufferDPort0Final.Value(previousTotal + 1:totalSamples) = bufferDPort0;
        
        if (plotLiveData == PicoConstants.TRUE)
            
            % Time axis
        
            % Multiply by ratio mode as samples get reduced
            time = (double(actualSampleInterval) * double(downSampleRatio)) * (previousTotal:(totalSamples - 1));
        
            % Plot channel A and Digital PORT0 (combined values) only.
            plot(analogueAxes, time, bufferChAmV);
            plot(digitalAxes, time, bufferDPort0);
            
        end
        
        % Clear variables for use again.
        clear bufferChAMV;
        clear bufferChBMV;
        clear bufferPortD0;
        clear firstValuePosn;
        clear lastValuePosn;
        clear startIndex;
        clear triggered;
        clear triggerAt;
        
    end
    
    % Check if auto stop has occurred
    hasAutoStopped = invoke(streamingGroupObj, 'autoStopped');
    
    if (hasAutoStopped == PicoConstants.TRUE)
        
        disp('AutoStop: TRUE - exiting loop.');
        break;
        
    end
    
    % Check if 'STOP' button pressed
    flag = getappdata(gcf, 'run');
    drawnow;
    
    if (flag == 0)
        
        disp('STOP button clicked - aborting data collection.')
        break;
        
    end
    
end

% Close the STOP button window.
if (exist('stopFig', 'var'))
    
    close('Stop Button');
    clear stopFig;
    
end

if (plotLiveData == PicoConstants.TRUE)
    
    drawnow;
    
    % Take hold off the axes.
    hold(analogueAxes, 'off');
    hold(digitalAxes, 'off');
    
end

if (hasTriggered == PicoConstants.TRUE)
    
    fprintf('Triggered at overall index: %d\n', triggeredAtIndex);
    
end

fprintf('\n');

%% Stop the Device
% This function should be called regardless of whether the autoStop
% property is enabled or not.

[status.stop] = invoke(ps2000aDeviceObj, 'ps2000aStop');

%% Find the Number of Samples.
% This is the number of samples held in the driver itself. The actual
% number of samples collected when using a trigger is likely to be greater.
[status.noOfStreamingValues, numStreamingValues] = invoke(streamingGroupObj, 'ps2000aNoOfStreamingValues');

fprintf('Number of samples available from the driver: %u.\n\n', numStreamingValues);

%% Process Data
% Process data post-capture if required - here the data will be plotted.

% Reduce size of arrays if required.
if (totalSamples < maxSamples)
    
    pBufferChAFinal.Value(totalSamples + 1:end)     = [];
    pBufferChBFinal.Value(totalSamples + 1:end)     = [];
    pBufferDPort0Final.Value(totalSamples + 1:end)  = [];
    
end

% Retrieve data for Channels A and B, and PORT0.
channelAFinal   = pBufferChAFinal.Value();
channelBFinal   = pBufferChBFinal.Value();
dPort0Final     = pBufferDPort0Final.Value();

% Plot total analog and digital data collected on separate figures.

%%
% *Analog Data*

scrsz = get(groot,'ScreenSize');

analogueFinalFigure = figure('Name','PicoScope 2000 Series (A API) Example - MSO Streaming Mode Capture', ...
    'NumberTitle', 'off', 'Position', [1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);

movegui(analogueFinalFigure, 'west');

analogueFinalAxes = axes('Parent', analogueFinalFigure);
hold(analogueFinalAxes, 'on');

title(analogueFinalAxes, 'Streaming Data Acquisition (Final)');

if (strcmp(sampleIntervalTimeUnitsStr, 'us'))
        
    xLabelStr = 'Time (\mus)';
        
else
       
    xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')');
        
end


xlabel(analogueFinalAxes, xLabelStr);
ylabel(analogueFinalAxes, 'Voltage (mV)');

% Find the maximum voltage range
maxYRange = max(channelARangeMV, channelBRangeMV);
ylim(analogueFinalAxes,[(-1 * maxYRange) maxYRange]);

time = (double(actualSampleInterval) * double(downSampleRatio)) * (0:length(channelAFinal) - 1);
plot(analogueFinalAxes, time, channelAFinal, time, channelBFinal);

grid(analogueFinalAxes, 'on');
legend(analogueFinalAxes, 'Channel A', 'Channel B');

hold(analogueFinalAxes, 'off');

%% 
% *Digital Data*

digitalFinalFigure = figure('Name','PicoScope 2000 Series (A API) Example - MSO Streaming Mode Capture', ...
    'NumberTitle', 'off', 'Position', [scrsz(3)/2 + 1 scrsz(4)/4 scrsz(3)/2 scrsz(4)/2]);

movegui(digitalFinalFigure, 'east');

disp('Converting digital integer data to binary...');

dPort0Binary = zeros(length(dPort0Final), 8);

% Retrieve the bit values from the lower 8 bits of the 16-bit values
% returned for dPort0 - each bit corresponds to a digital channel. Channel
% D0 data will be in column 8 and D7 data will be in column 1.
for sample = 1:length(dPort0Final)
    
    dPort0Binary(sample,:)= bitget(dPort0Final(sample), 8:-1:1, 'int16');
    
end

% Specify colours to use for the plots - the colour to use will be selected
% according to the digital channel.
digiPlotColours = ['m', 'b', 'r', 'g'];

% Display digital data in a 4 x 2 grid
for i = 1:8
    
    subplot(4, 2, i); 
    plot(time, dPort0Binary(:, (8 - (i - 1))), digiPlotColours(rem(i, length(digiPlotColours)) + 1));
    title(strcat('Digital Channel D', num2str(i - 1)));
    xlabel(strcat('Time (', sampleIntervalTimeUnitsStr, ')'));
    ylabel('Logic Level');
    axis([-inf, inf, -0.5, 1.5])
    grid on;
    
end

%% Disconnect Device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);
%% PicoScope 2000 Series (A API) Instrument Driver Signal Generator Example
% Code for communicating with an instrument in order to control the
% signal generator.
%
% This is a modified version of a machine generated representation of an 
% instrument control session using a device object. The instrument 
% control session comprises all the steps you are likely to take when 
% communicating with your instrument. 
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
% PS2000A_ID_Sig_Gen_Example, at the MATLAB command prompt.
% 
% The file, PS2000A_ID_SIG_GEN_EXAMPLE.M must be on your MATLAB PATH. For
% additional information on setting your MATLAB PATH, type 'help addpath'
% at the MATLAB command prompt.
%
% *Example:*
%   PS2000A_ID_Sig_Gen_Example;
%
% *Description:*
%     Demonstrates how to set properties and call functions in order to
%     control the signal generator output of a PicoScope 2000 Series
%     Oscilloscope/Mixed Signal Oscilloscope using the 'A' API library
%     functions.
%
% *See also:* <matlab:doc('icdevice') |icdevice|> | <matlab:doc('instrument/invoke') |invoke|>
%
% *Copyright:* © 2015-2017 Pico Technology Ltd. See LICENSE file for terms.

%% Test setup
% For this example the 'AWG' connector of the oscilloscope was connected to
% channel A on another PicoScope oscilloscope running the PicoScope 6
% software application. Images, where shown, depict output, or part of the
% output in the PicoScope 6 display.
%
% *Note:* The various signal generator functions called in this script may
% be combined with the functions used in the various data acquisition
% examples in order to output a signal and acquire data. The functions to
% setup the signal generator should be called prior to the start of data
% collection.

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

%% Obtain Signalgenerator group object
% Signal Generator properties and functions are located in the Instrument
% Driver's Signalgenerator group.

sigGenGroupObj = get(ps2000aDeviceObj, 'Signalgenerator');
sigGenGroupObj = sigGenGroupObj(1);

%% Function generator - simple
% Output a sine wave, 2000 mVpp, 0 mV offset, 1000 Hz (uses preset values
% for offset, peak to peak voltage and frequency from the Signalgenerator
% groups's properties).

% waveType : 0 (ps2000aEnuminfo.enPS2000AWaveType.PS2000A_SINE)

[status.setSigGenBuiltInSimple] = invoke(sigGenGroupObj, 'setSigGenBuiltInSimple', 0);

%%
% 
% <<../images/ps2000a_sine_wave_1kHz.PNG>>
% 

%% Function generator - sweep frequency
% Output a square wave, 2400 mVpp, 500 mV offset, and sweep continuously
% from 500 Hz to 50 Hz in steps of 50 Hz.

% Configure property value(s).
set(ps2000aDeviceObj.Signalgenerator(1), 'startFrequency', 50.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'stopFrequency', 500.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'offsetVoltage', 500.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'peakToPeakVoltage', 2400.0);

% Execute device object function(s).
%
% Wavetype       : 1 (ps2000aEnuminfo.enPS2000AWaveType.PS2000A_SQUARE) 
% Increment      : 50.0 Hz
% Dwell Time     : 1 s
% Sweep Type     : 1 (ps2000aEnuminfo.enPS2000ASweepType.PS2000A_DOWN)
% Operation      : 0 (ps2000aEnuminfo.enPS2000AExtraOperations.PS2000A_ES_OFF)
% Shots          : 0 
% Sweeps         : 0
% Trigger Type   : 0 (ps2000aEnuminfo.enPS2000ASigGenTrigType.PS2000A_SIGGEN_RISING)
% Trigger Source : 0 (ps2000aEnuminfo.enPS2000ASigGenTrigSource.PS2000A_SIGGEN_NONE)
% Ext. Threshold : 0 mV (Only supported by PicoScope 2206/7/8 models)

invoke(sigGenGroupObj, 'setSigGenBuiltIn', 1, 50.0, 1, 1, 0, 0, 0, 0, 0, 0);

%%
% 
% <<../images/ps2000a_square_wave_sweep_500Hz.PNG>>
% 

%%
% 
% <<../images/ps2000a_square_wave_sweep_200Hz.PNG>>
% 

%% Turn off signal generator
% Sets the output to 0 V DC.

[status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');

%%
% 
% <<../images/ps2000a_sig_gen_off.PNG>>
% 

%% Arbitrary waveform generator - set parameters
% Set parameters (2000 mVpp, 0 mV offset, 2000 Hz frequency) and define an
% arbitrary waveform.

% Configure property value(s).
set(ps2000aDeviceObj.Signalgenerator(1), 'startFrequency', 2000.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'stopFrequency', 2000.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'offsetVoltage', 0.0);
set(ps2000aDeviceObj.Signalgenerator(1), 'peakToPeakVoltage', 2000.0);

%% 
% Define an Arbitrary Waveform - values must be in the range -1 to +1.
% Arbitrary waveforms can also be read in from text and csv files using
% <matlab:doc('dlmread') |dlmread|> and <matlab:doc('csvread') |csvread|>
% respectively or use the |importAWGFile| function from the <https://uk.mathworks.com/matlabcentral/fileexchange/53681-picoscope-support-toolbox PicoScope
% Support Toolbox>.
%
% Any AWG files created using the PicoScope 6 application can be read using
% the above method.

awgBufferSize = get(sigGenGroupObj, 'awgBufferSize');
x = linspace(0, 360, awgBufferSize);
y = normalise(sind(x) + sind(2*x + 90) + sind(4*x + 45));

%% Arbitrary waveform generator - simple
% Output an arbitrary waveform with constant frequency (defined above).

% Arb. Waveform : y (defined above)

[status.setSigGenArbitrarySimple] = invoke(sigGenGroupObj, 'setSigGenArbitrarySimple', y);

%%
% 
% <<../images/ps2000a_arbitrary_waveform.PNG>>
% 

%% Turn off signal generator
% Sets the output to 0 V DC.

[status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');

%% Arbitrary waveform generator - output shots
% Output 2 cycles of an arbitrary waveform using a software trigger.
%
% Note that the signal generator will output the value coresponding to the
% first sample in the arbitrary waveform until the trigger event occurs.

% Increment      : 0 Hz
% Dwell Time     : 1 s
% Arb. Waveform  : y (defined above)
% Sweep Type     : 0 (ps2000aEnuminfo.enPS2000ASweepType.PS2000A_UP)
% Operation      : 0 (ps2000aEnuminfo.enPS2000AExtraOperations.PS2000A_ES_OFF)
% Index Mode     : 0 (ps2000aEnuminfo.enPS2000AIndexMode.PS2000A_SINGLE)
% Shots          : 2 
% Sweeps         : 0
% Trigger Type   : 0 (ps2000aEnuminfo.enPS2000ASigGenTrigType.PS2000A_SIGGEN_RISING)
% Trigger Source : 4 (ps2000aEnuminfo.enPS2000ASigGenTrigSource.PS2000A_SIGGEN_SOFT_TRIG)
% Ext. Threshold : 0 mV (Only supported by PicoScope 2206/7/8 models)

[status.setSigGenArbitrary] = invoke(sigGenGroupObj, 'setSigGenArbitrary', 0, 1, y, 0, 0, 0, 2, 0, 0, 4, 0);

% Trigger the AWG

% State : 1 (a non-zero value will trigger the output)
[status.sigGenSoftwareControl] = invoke(sigGenGroupObj, 'ps2000aSigGenSoftwareControl', 1);

%%
% 
% <<../images/ps2000a_arbitrary_waveform_shots.PNG>>
% 

%% Turn off signal generator
% Sets the output to 0 V DC.

[status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');

%% Disconnect device
% Disconnect device object from hardware.

disconnect(ps2000aDeviceObj);
delete(ps2000aDeviceObj);

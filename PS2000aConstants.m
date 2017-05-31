%% PS2000aConstants 
%
% The PS2000aConstants class defines a number of constant values from the
% ps2000aApi.h header file that can be used to define the properties of a
% PicoScope 2000 Series Oscilloscope/Mixed Signal Oscilloscope or for
% passing as parameters to function calls.
%
% The properties in this file are divided into the following
% sub-sections:
% 
% * ETS Mode Properties
% * ADC Count Properties
% * Analog offset values
% * Function/Arbitrary Waveform Parameters
% * Maximum/Minimum Waveform Frequencies
% * PicoScope 2000 Series Models using this driver
%
% Ensure that the location of this class file is on the MATLAB Path.		
%
% Copyright: © 2013 - 2017 Pico Technology Ltd. See LICENSE file for terms.	

classdef PS2000aConstants
    
    properties (Constant)
        
        % ETS Mode properties
        PS2208_MAX_ETS_CYCLES	= 500;
        PS2208_MAX_INTERLEAVE	= 20;

        PS2207_MAX_ETS_CYCLES	= 500;
        PS2207_MAX_INTERLEAVE	= 20;

        PS2206_MAX_ETS_CYCLES	= 250;
        PS2206_MAX_INTERLEAVE	= 10;

        % External Channel ADC Count
        PS2000A_EXT_MAX_VALUE   = 32767;
        PS2000A_EXT_MIN_VALUE   = -32767;
        
        PS2000A_EXT_MAX_VOLTAGE = 5;
        PS2000A_EXT_MIN_VOLTAGE = -5;
        
        PS2000A_MAX_LOGIC_LEVEL	= 32767;
        PS2000A_MIN_LOGIC_LEVEL = -32767;
        
        PS2000A_MAX_LOGIC_VOLTAGE = 5;
        PS2000A_MIN_LOGIC_VOLTAGE = -5;
        
        % Function/Arbitrary Waveform Parameters
        MIN_SIG_GEN_FREQ = 0.0;
        MAX_SIG_GEN_FREQ = 20000000.0;

        PS2000A_MAX_SIG_GEN_BUFFER_SIZE = PicoConstants.AWG_BUFFER_8KS;
        PS2000A_MIN_SIG_GEN_BUFFER_SIZE = 1;
        
        MIN_DWELL_COUNT                 = 3;
        MAX_SWEEPS_SHOTS				= pow2(30) - 1; %1073741823

        MAX_ANALOGUE_OFFSET_50MV_200MV = 0.250;
        MIN_ANALOGUE_OFFSET_50MV_200MV = -0.250;
        MAX_ANALOGUE_OFFSET_500MV_2V   = 2.500;
        MIN_ANALOGUE_OFFSET_500MV_2V   = -2.500;
        MAX_ANALOGUE_OFFSET_5V_20V     = 20;
        MIN_ANALOGUE_OFFSET_5V_20V	   = -20; 

        % Supported by the PicoScope 2000 Series models with the exception
        % of the PicoScope 2205 MSO.
        PS2000A_SHOT_SWEEP_TRIGGER_CONTINUOUS_RUN = hex2dec('FFFFFFFF');
        
        % PicoScope 2205MSO only
        PS2000A_AWG_DDS_FREQUENCY = 48e6; % DDS Frequency of 48MHz.

        % Frequencies
        
        PS2000A_SINE_MAX_FREQUENCY		= 1000000;
        PS2000A_SQUARE_MAX_FREQUENCY	= 1000000;
        PS2000A_TRIANGLE_MAX_FREQUENCY	= 1000000;
        PS2000A_SINC_MAX_FREQUENCY		= 1000000;
        PS2000A_RAMP_MAX_FREQUENCY		= 1000000;
        PS2000A_HALF_SINE_MAX_FREQUENCY	= 1000000;
        PS2000A_GAUSSIAN_MAX_FREQUENCY  = 1000000;
        PS2000A_PRBS_MAX_FREQUENCY		= 1000000;
        PS2000A_PRBS_MIN_FREQUENCY		= 0.03;
        PS2000A_MIN_FREQUENCY			= 0.03;
        
    end

end


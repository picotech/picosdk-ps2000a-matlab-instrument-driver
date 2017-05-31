function [methodinfo,structs,enuminfo,ThunkLibName]=ps2000aMFile_win64
%PS2000AMFILE_WIN64 Create structures to define interfaces found in 'ps2000aApi'.

%This function was generated by loadlibrary.m parser version  on Fri Jan 27 14:30:44 2017
%perl options:'ps2000aApi.i -outfile=ps2000aMFile_win64.m -thunkfile=ps2000a_thunk_pcwin64.c -header=ps2000aApi.h'
ival={cell(1,0)}; % change 0 to the actual number of functions to preallocate the data.
structs=[];enuminfo=[];fcnNum=1;
fcns=struct('name',ival,'calltype',ival,'LHS',ival,'RHS',ival,'alias',ival,'thunkname', ival);
MfilePath=fileparts(mfilename('fullpath'));
ThunkLibName=fullfile(MfilePath,'ps2000a_thunk_pcwin64');
% PICO_STATUS __stdcall ps2000aOpenUnit ( int16_t * handle , char * serial ); 
fcns.thunkname{fcnNum}='uint32voidPtrcstringThunk';fcns.name{fcnNum}='ps2000aOpenUnit'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16Ptr', 'cstring'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aOpenUnitAsync ( int16_t * status , char * serial ); 
fcns.thunkname{fcnNum}='uint32voidPtrcstringThunk';fcns.name{fcnNum}='ps2000aOpenUnitAsync'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16Ptr', 'cstring'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aOpenUnitProgress ( int16_t * handle , int16_t * progressPercent , int16_t * complete ); 
fcns.thunkname{fcnNum}='uint32voidPtrvoidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aOpenUnitProgress'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16Ptr', 'int16Ptr', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetUnitInfo ( int16_t handle , char * string , int16_t stringLength , int16_t * requiredSize , PICO_INFO info ); 
fcns.thunkname{fcnNum}='uint32int16cstringint16voidPtruint32Thunk';fcns.name{fcnNum}='ps2000aGetUnitInfo'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'cstring', 'int16', 'int16Ptr', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aFlashLed ( int16_t handle , int16_t start ); 
fcns.thunkname{fcnNum}='uint32int16int16Thunk';fcns.name{fcnNum}='ps2000aFlashLed'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aCloseUnit ( int16_t handle ); 
fcns.thunkname{fcnNum}='uint32int16Thunk';fcns.name{fcnNum}='ps2000aCloseUnit'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aMemorySegments ( int16_t handle , uint32_t nSegments , int32_t * nMaxSamples ); 
fcns.thunkname{fcnNum}='uint32int16uint32voidPtrThunk';fcns.name{fcnNum}='ps2000aMemorySegments'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'int32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetChannel ( int16_t handle , PS2000A_CHANNEL channel , int16_t enabled , PS2000A_COUPLING type , PS2000A_RANGE range , float analogOffset ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_CHANNELint16PS2000A_COUPLINGPS2000A_RANGEfloatThunk';fcns.name{fcnNum}='ps2000aSetChannel'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000AChannel', 'int16', 'enPS2000ACoupling', 'enPS2000ARange', 'single'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetDigitalPort ( int16_t handle , PS2000A_DIGITAL_PORT port , int16_t enabled , int16_t logicLevel ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_DIGITAL_PORTint16int16Thunk';fcns.name{fcnNum}='ps2000aSetDigitalPort'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000ADigitalPort', 'int16', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetNoOfCaptures ( int16_t handle , uint32_t nCaptures ); 
fcns.thunkname{fcnNum}='uint32int16uint32Thunk';fcns.name{fcnNum}='ps2000aSetNoOfCaptures'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetTimebase ( int16_t handle , uint32_t timebase , int32_t noSamples , int32_t * timeIntervalNanoseconds , int16_t oversample , int32_t * maxSamples , uint32_t segmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16uint32int32voidPtrint16voidPtruint32Thunk';fcns.name{fcnNum}='ps2000aGetTimebase'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'int32', 'int32Ptr', 'int16', 'int32Ptr', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetTimebase2 ( int16_t handle , uint32_t timebase , int32_t noSamples , float * timeIntervalNanoseconds , int16_t oversample , int32_t * maxSamples , uint32_t segmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16uint32int32voidPtrint16voidPtruint32Thunk';fcns.name{fcnNum}='ps2000aGetTimebase2'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'int32', 'singlePtr', 'int16', 'int32Ptr', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSigGenArbitrary ( int16_t handle , int32_t offsetVoltage , uint32_t pkToPk , uint32_t startDeltaPhase , uint32_t stopDeltaPhase , uint32_t deltaPhaseIncrement , uint32_t dwellCount , int16_t * arbitraryWaveform , int32_t arbitraryWaveformSize , PS2000A_SWEEP_TYPE sweepType , PS2000A_EXTRA_OPERATIONS operation , PS2000A_INDEX_MODE indexMode , uint32_t shots , uint32_t sweeps , PS2000A_SIGGEN_TRIG_TYPE triggerType , PS2000A_SIGGEN_TRIG_SOURCE triggerSource , int16_t extInThreshold ); 
fcns.thunkname{fcnNum}='uint32int16int32uint32uint32uint32uint32uint32voidPtrint32PS2000A_SWEEP_TYPEPS2000A_EXTRA_OPERATIONSPS2000A_INDEX_MODEuint32uint32PS2000A_SIGGEN_TRIG_TYPEPS2000A_SIGGEN_TRIG_SOURCEint16Thunk';fcns.name{fcnNum}='ps2000aSetSigGenArbitrary'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'uint32', 'uint32', 'uint32', 'uint32', 'uint32', 'int16Ptr', 'int32', 'enPS2000ASweepType', 'enPS2000AExtraOperations', 'enPS2000AIndexMode', 'uint32', 'uint32', 'enPS2000ASigGenTrigType', 'enPS2000ASigGenTrigSource', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSigGenBuiltIn ( int16_t handle , int32_t offsetVoltage , uint32_t pkToPk , int16_t waveType , float startFrequency , float stopFrequency , float increment , float dwellTime , PS2000A_SWEEP_TYPE sweepType , PS2000A_EXTRA_OPERATIONS operation , uint32_t shots , uint32_t sweeps , PS2000A_SIGGEN_TRIG_TYPE triggerType , PS2000A_SIGGEN_TRIG_SOURCE triggerSource , int16_t extInThreshold ); 
fcns.thunkname{fcnNum}='uint32int16int32uint32int16floatfloatfloatfloatPS2000A_SWEEP_TYPEPS2000A_EXTRA_OPERATIONSuint32uint32PS2000A_SIGGEN_TRIG_TYPEPS2000A_SIGGEN_TRIG_SOURCEint16Thunk';fcns.name{fcnNum}='ps2000aSetSigGenBuiltIn'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'uint32', 'int16', 'single', 'single', 'single', 'single', 'enPS2000ASweepType', 'enPS2000AExtraOperations', 'uint32', 'uint32', 'enPS2000ASigGenTrigType', 'enPS2000ASigGenTrigSource', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSigGenBuiltInV2 ( int16_t handle , int32_t offsetVoltage , uint32_t pkToPk , int16_t waveType , double startFrequency , double stopFrequency , double increment , double dwellTime , PS2000A_SWEEP_TYPE sweepType , PS2000A_EXTRA_OPERATIONS operation , uint32_t shots , uint32_t sweeps , PS2000A_SIGGEN_TRIG_TYPE triggerType , PS2000A_SIGGEN_TRIG_SOURCE triggerSource , int16_t extInThreshold ); 
fcns.thunkname{fcnNum}='uint32int16int32uint32int16doubledoubledoubledoublePS2000A_SWEEP_TYPEPS2000A_EXTRA_OPERATIONSuint32uint32PS2000A_SIGGEN_TRIG_TYPEPS2000A_SIGGEN_TRIG_SOURCEint16Thunk';fcns.name{fcnNum}='ps2000aSetSigGenBuiltInV2'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'uint32', 'int16', 'double', 'double', 'double', 'double', 'enPS2000ASweepType', 'enPS2000AExtraOperations', 'uint32', 'uint32', 'enPS2000ASigGenTrigType', 'enPS2000ASigGenTrigSource', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSigGenPropertiesArbitrary ( int16_t handle , uint32_t startDeltaPhase , uint32_t stopDeltaPhase , uint32_t deltaPhaseIncrement , uint32_t dwellCount , PS2000A_SWEEP_TYPE sweepType , uint32_t shots , uint32_t sweeps , PS2000A_SIGGEN_TRIG_TYPE triggerType , PS2000A_SIGGEN_TRIG_SOURCE triggerSource , int16_t extInThreshold ); 
fcns.thunkname{fcnNum}='uint32int16uint32uint32uint32uint32PS2000A_SWEEP_TYPEuint32uint32PS2000A_SIGGEN_TRIG_TYPEPS2000A_SIGGEN_TRIG_SOURCEint16Thunk';fcns.name{fcnNum}='ps2000aSetSigGenPropertiesArbitrary'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32', 'uint32', 'uint32', 'enPS2000ASweepType', 'uint32', 'uint32', 'enPS2000ASigGenTrigType', 'enPS2000ASigGenTrigSource', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSigGenPropertiesBuiltIn ( int16_t handle , double startFrequency , double stopFrequency , double increment , double dwellTime , PS2000A_SWEEP_TYPE sweepType , uint32_t shots , uint32_t sweeps , PS2000A_SIGGEN_TRIG_TYPE triggerType , PS2000A_SIGGEN_TRIG_SOURCE triggerSource , int16_t extInThreshold ); 
fcns.thunkname{fcnNum}='uint32int16doubledoubledoubledoublePS2000A_SWEEP_TYPEuint32uint32PS2000A_SIGGEN_TRIG_TYPEPS2000A_SIGGEN_TRIG_SOURCEint16Thunk';fcns.name{fcnNum}='ps2000aSetSigGenPropertiesBuiltIn'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'double', 'double', 'double', 'double', 'enPS2000ASweepType', 'uint32', 'uint32', 'enPS2000ASigGenTrigType', 'enPS2000ASigGenTrigSource', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSigGenFrequencyToPhase ( int16_t handle , double frequency , PS2000A_INDEX_MODE indexMode , uint32_t bufferLength , uint32_t * phase ); 
fcns.thunkname{fcnNum}='uint32int16doublePS2000A_INDEX_MODEuint32voidPtrThunk';fcns.name{fcnNum}='ps2000aSigGenFrequencyToPhase'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'double', 'enPS2000AIndexMode', 'uint32', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSigGenArbitraryMinMaxValues ( int16_t handle , int16_t * minArbitraryWaveformValue , int16_t * maxArbitraryWaveformValue , uint32_t * minArbitraryWaveformSize , uint32_t * maxArbitraryWaveformSize ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrvoidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aSigGenArbitraryMinMaxValues'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr', 'int16Ptr', 'uint32Ptr', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSigGenSoftwareControl ( int16_t handle , int16_t state ); 
fcns.thunkname{fcnNum}='uint32int16int16Thunk';fcns.name{fcnNum}='ps2000aSigGenSoftwareControl'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetEts ( int16_t handle , PS2000A_ETS_MODE mode , int16_t etsCycles , int16_t etsInterleave , int32_t * sampleTimePicoseconds ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_ETS_MODEint16int16voidPtrThunk';fcns.name{fcnNum}='ps2000aSetEts'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000AEtsMode', 'int16', 'int16', 'int32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetSimpleTrigger ( int16_t handle , int16_t enable , PS2000A_CHANNEL source , int16_t threshold , PS2000A_THRESHOLD_DIRECTION direction , uint32_t delay , int16_t autoTrigger_ms ); 
fcns.thunkname{fcnNum}='uint32int16int16PS2000A_CHANNELint16PS2000A_THRESHOLD_DIRECTIONuint32int16Thunk';fcns.name{fcnNum}='ps2000aSetSimpleTrigger'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16', 'enPS2000AChannel', 'int16', 'enPS2000AThresholdDirection', 'uint32', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetTriggerDigitalPortProperties ( int16_t handle , PS2000A_DIGITAL_CHANNEL_DIRECTIONS * directions , int16_t nDirections ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint16Thunk';fcns.name{fcnNum}='ps2000aSetTriggerDigitalPortProperties'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'tPS2000ADigitalChannelDirectionsPtr', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetDigitalAnalogTriggerOperand ( int16_t handle , PS2000A_TRIGGER_OPERAND operand ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_TRIGGER_OPERANDThunk';fcns.name{fcnNum}='ps2000aSetDigitalAnalogTriggerOperand'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000ATriggerOperand'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetPulseWidthDigitalPortProperties ( int16_t handle , PS2000A_DIGITAL_CHANNEL_DIRECTIONS * directions , int16_t nDirections ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint16Thunk';fcns.name{fcnNum}='ps2000aSetPulseWidthDigitalPortProperties'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'tPS2000ADigitalChannelDirectionsPtr', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetTriggerChannelProperties ( int16_t handle , PS2000A_TRIGGER_CHANNEL_PROPERTIES * channelProperties , int16_t nChannelProperties , int16_t auxOutputEnable , int32_t autoTriggerMilliseconds ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint16int16int32Thunk';fcns.name{fcnNum}='ps2000aSetTriggerChannelProperties'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'tPS2000ATriggerChannelPropertiesPtr', 'int16', 'int16', 'int32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetTriggerChannelConditions ( int16_t handle , PS2000A_TRIGGER_CONDITIONS * conditions , int16_t nConditions ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint16Thunk';fcns.name{fcnNum}='ps2000aSetTriggerChannelConditions'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'tPS2000ATriggerConditionsPtr', 'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetTriggerChannelDirections ( int16_t handle , PS2000A_THRESHOLD_DIRECTION channelA , PS2000A_THRESHOLD_DIRECTION channelB , PS2000A_THRESHOLD_DIRECTION channelC , PS2000A_THRESHOLD_DIRECTION channelD , PS2000A_THRESHOLD_DIRECTION ext , PS2000A_THRESHOLD_DIRECTION aux ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_THRESHOLD_DIRECTIONPS2000A_THRESHOLD_DIRECTIONPS2000A_THRESHOLD_DIRECTIONPS2000A_THRESHOLD_DIRECTIONPS2000A_THRESHOLD_DIRECTIONPS2000A_THRESHOLD_DIRECTIONThunk';fcns.name{fcnNum}='ps2000aSetTriggerChannelDirections'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000AThresholdDirection', 'enPS2000AThresholdDirection', 'enPS2000AThresholdDirection', 'enPS2000AThresholdDirection', 'enPS2000AThresholdDirection', 'enPS2000AThresholdDirection'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetTriggerDelay ( int16_t handle , uint32_t delay ); 
fcns.thunkname{fcnNum}='uint32int16uint32Thunk';fcns.name{fcnNum}='ps2000aSetTriggerDelay'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetPulseWidthQualifier ( int16_t handle , PS2000A_PWQ_CONDITIONS * conditions , int16_t nConditions , PS2000A_THRESHOLD_DIRECTION direction , uint32_t lower , uint32_t upper , PS2000A_PULSE_WIDTH_TYPE type ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint16PS2000A_THRESHOLD_DIRECTIONuint32uint32PS2000A_PULSE_WIDTH_TYPEThunk';fcns.name{fcnNum}='ps2000aSetPulseWidthQualifier'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'tPS2000APwqConditionsPtr', 'int16', 'enPS2000AThresholdDirection', 'uint32', 'uint32', 'enPS2000APulseWidthType'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aIsTriggerOrPulseWidthQualifierEnabled ( int16_t handle , int16_t * triggerEnabled , int16_t * pulseWidthQualifierEnabled ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aIsTriggerOrPulseWidthQualifierEnabled'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetTriggerTimeOffset ( int16_t handle , uint32_t * timeUpper , uint32_t * timeLower , uint32_t * timeUnits , uint32_t segmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrvoidPtruint32Thunk';fcns.name{fcnNum}='ps2000aGetTriggerTimeOffset'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr', 'uint32Ptr', 'uint32Ptr', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetTriggerTimeOffset64 ( int16_t handle , int64_t * time , uint32_t * timeUnits , uint32_t segmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtruint32Thunk';fcns.name{fcnNum}='ps2000aGetTriggerTimeOffset64'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int64Ptr', 'uint32Ptr', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesTriggerTimeOffsetBulk ( int16_t handle , uint32_t * timesUpper , uint32_t * timesLower , uint32_t * timeUnits , uint32_t fromSegmentIndex , uint32_t toSegmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrvoidPtruint32uint32Thunk';fcns.name{fcnNum}='ps2000aGetValuesTriggerTimeOffsetBulk'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr', 'uint32Ptr', 'uint32Ptr', 'uint32', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesTriggerTimeOffsetBulk64 ( int16_t handle , int64_t * times , uint32_t * timeUnits , uint32_t fromSegmentIndex , uint32_t toSegmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtruint32uint32Thunk';fcns.name{fcnNum}='ps2000aGetValuesTriggerTimeOffsetBulk64'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int64Ptr', 'uint32Ptr', 'uint32', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetNoOfCaptures ( int16_t handle , uint32_t * nCaptures ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aGetNoOfCaptures'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetNoOfProcessedCaptures ( int16_t handle , uint32_t * nProcessedCaptures ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aGetNoOfProcessedCaptures'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetDataBuffer ( int16_t handle , int32_t channelOrPort , int16_t * buffer , int32_t bufferLth , uint32_t segmentIndex , PS2000A_RATIO_MODE mode ); 
fcns.thunkname{fcnNum}='uint32int16int32voidPtrint32uint32PS2000A_RATIO_MODEThunk';fcns.name{fcnNum}='ps2000aSetDataBuffer'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'int16Ptr', 'int32', 'uint32', 'enPS2000ARatioMode'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetDataBuffers ( int16_t handle , int32_t channelOrPort , int16_t * bufferMax , int16_t * bufferMin , int32_t bufferLth , uint32_t segmentIndex , PS2000A_RATIO_MODE mode ); 
fcns.thunkname{fcnNum}='uint32int16int32voidPtrvoidPtrint32uint32PS2000A_RATIO_MODEThunk';fcns.name{fcnNum}='ps2000aSetDataBuffers'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'int16Ptr', 'int16Ptr', 'int32', 'uint32', 'enPS2000ARatioMode'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetEtsTimeBuffer ( int16_t handle , int64_t * buffer , int32_t bufferLth ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrint32Thunk';fcns.name{fcnNum}='ps2000aSetEtsTimeBuffer'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int64Ptr', 'int32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetEtsTimeBuffers ( int16_t handle , uint32_t * timeUpper , uint32_t * timeLower , int32_t bufferLth ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrint32Thunk';fcns.name{fcnNum}='ps2000aSetEtsTimeBuffers'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr', 'uint32Ptr', 'int32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aIsReady ( int16_t handle , int16_t * ready ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aIsReady'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aRunBlock ( int16_t handle , int32_t noOfPreTriggerSamples , int32_t noOfPostTriggerSamples , uint32_t timebase , int16_t oversample , int32_t * timeIndisposedMs , uint32_t segmentIndex , void * lpReady , void * pParameter ); 
fcns.thunkname{fcnNum}='uint32int16int32int32uint32int16voidPtruint32voidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aRunBlock'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int32', 'int32', 'uint32', 'int16', 'int32Ptr', 'uint32', 'voidPtr', 'voidPtr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aRunStreaming ( int16_t handle , uint32_t * sampleInterval , PS2000A_TIME_UNITS sampleIntervalTimeUnits , uint32_t maxPreTriggerSamples , uint32_t maxPostPreTriggerSamples , int16_t autoStop , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t overviewBufferSize ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrPS2000A_TIME_UNITSuint32uint32int16uint32PS2000A_RATIO_MODEuint32Thunk';fcns.name{fcnNum}='ps2000aRunStreaming'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr', 'enPS2000ATimeUnits', 'uint32', 'uint32', 'int16', 'uint32', 'enPS2000ARatioMode', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetStreamingLatestValues ( int16_t handle , void * lpPs2000aReady , void * pParameter ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aGetStreamingLatestValues'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'voidPtr', 'voidPtr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aNoOfStreamingValues ( int16_t handle , uint32_t * noOfValues ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aNoOfStreamingValues'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetMaxDownSampleRatio ( int16_t handle , uint32_t noOfUnaggreatedSamples , uint32_t * maxDownSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t segmentIndex ); 
fcns.thunkname{fcnNum}='uint32int16uint32voidPtrPS2000A_RATIO_MODEuint32Thunk';fcns.name{fcnNum}='ps2000aGetMaxDownSampleRatio'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32Ptr', 'enPS2000ARatioMode', 'uint32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValues ( int16_t handle , uint32_t startIndex , uint32_t * noOfSamples , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t segmentIndex , int16_t * overflow ); 
fcns.thunkname{fcnNum}='uint32int16uint32voidPtruint32PS2000A_RATIO_MODEuint32voidPtrThunk';fcns.name{fcnNum}='ps2000aGetValues'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32Ptr', 'uint32', 'enPS2000ARatioMode', 'uint32', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesBulk ( int16_t handle , uint32_t * noOfSamples , uint32_t fromSegmentIndex , uint32_t toSegmentIndex , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , int16_t * overflow ); 
fcns.thunkname{fcnNum}='uint32int16voidPtruint32uint32uint32PS2000A_RATIO_MODEvoidPtrThunk';fcns.name{fcnNum}='ps2000aGetValuesBulk'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr', 'uint32', 'uint32', 'uint32', 'enPS2000ARatioMode', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesAsync ( int16_t handle , uint32_t startIndex , uint32_t noOfSamples , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t segmentIndex , void * lpDataReady , void * pParameter ); 
fcns.thunkname{fcnNum}='uint32int16uint32uint32uint32PS2000A_RATIO_MODEuint32voidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aGetValuesAsync'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32', 'uint32', 'enPS2000ARatioMode', 'uint32', 'voidPtr', 'voidPtr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesOverlapped ( int16_t handle , uint32_t startIndex , uint32_t * noOfSamples , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t segmentIndex , int16_t * overflow ); 
fcns.thunkname{fcnNum}='uint32int16uint32voidPtruint32PS2000A_RATIO_MODEuint32voidPtrThunk';fcns.name{fcnNum}='ps2000aGetValuesOverlapped'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32Ptr', 'uint32', 'enPS2000ARatioMode', 'uint32', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetValuesOverlappedBulk ( int16_t handle , uint32_t startIndex , uint32_t * noOfSamples , uint32_t downSampleRatio , PS2000A_RATIO_MODE downSampleRatioMode , uint32_t fromSegmentIndex , uint32_t toSegmentIndex , int16_t * overflow ); 
fcns.thunkname{fcnNum}='uint32int16uint32voidPtruint32PS2000A_RATIO_MODEuint32uint32voidPtrThunk';fcns.name{fcnNum}='ps2000aGetValuesOverlappedBulk'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32', 'uint32Ptr', 'uint32', 'enPS2000ARatioMode', 'uint32', 'uint32', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aStop ( int16_t handle ); 
fcns.thunkname{fcnNum}='uint32int16Thunk';fcns.name{fcnNum}='ps2000aStop'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aHoldOff ( int16_t handle , uint64_t holdoff , PS2000A_HOLDOFF_TYPE type ); 
fcns.thunkname{fcnNum}='uint32int16uint64PS2000A_HOLDOFF_TYPEThunk';fcns.name{fcnNum}='ps2000aHoldOff'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint64', 'enPS2000AHoldOffType'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetChannelInformation ( int16_t handle , PS2000A_CHANNEL_INFO info , int32_t probe , int32_t * ranges , int32_t * length , int32_t channels ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_CHANNEL_INFOint32voidPtrvoidPtrint32Thunk';fcns.name{fcnNum}='ps2000aGetChannelInformation'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000AChannelInfo', 'int32', 'int32Ptr', 'int32Ptr', 'int32'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aEnumerateUnits ( int16_t * count , char * serials , int16_t * serialLth ); 
fcns.thunkname{fcnNum}='uint32voidPtrcstringvoidPtrThunk';fcns.name{fcnNum}='ps2000aEnumerateUnits'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16Ptr', 'cstring', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aPingUnit ( int16_t handle ); 
fcns.thunkname{fcnNum}='uint32int16Thunk';fcns.name{fcnNum}='ps2000aPingUnit'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aMaximumValue ( int16_t handle , int16_t * value ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aMaximumValue'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aMinimumValue ( int16_t handle , int16_t * value ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aMinimumValue'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetAnalogueOffset ( int16_t handle , PS2000A_RANGE range , PS2000A_COUPLING coupling , float * maximumVoltage , float * minimumVoltage ); 
fcns.thunkname{fcnNum}='uint32int16PS2000A_RANGEPS2000A_COUPLINGvoidPtrvoidPtrThunk';fcns.name{fcnNum}='ps2000aGetAnalogueOffset'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'enPS2000ARange', 'enPS2000ACoupling', 'singlePtr', 'singlePtr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aGetMaxSegments ( int16_t handle , uint32_t * maxSegments ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aGetMaxSegments'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'uint32Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aQueryOutputEdgeDetect ( int16_t handle , int16_t * state ); 
fcns.thunkname{fcnNum}='uint32int16voidPtrThunk';fcns.name{fcnNum}='ps2000aQueryOutputEdgeDetect'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16Ptr'};fcnNum=fcnNum+1;
% PICO_STATUS __stdcall ps2000aSetOutputEdgeDetect ( int16_t handle , int16_t state ); 
fcns.thunkname{fcnNum}='uint32int16int16Thunk';fcns.name{fcnNum}='ps2000aSetOutputEdgeDetect'; fcns.calltype{fcnNum}='Thunk'; fcns.LHS{fcnNum}='uint32'; fcns.RHS{fcnNum}={'int16', 'int16'};fcnNum=fcnNum+1;
structs.tPS2000ATriggerConditions.packing=1;
structs.tPS2000ATriggerConditions.members=struct('channelA', 'enPS2000ATriggerState', 'channelB', 'enPS2000ATriggerState', 'channelC', 'enPS2000ATriggerState', 'channelD', 'enPS2000ATriggerState', 'external', 'enPS2000ATriggerState', 'aux', 'enPS2000ATriggerState', 'pulseWidthQualifier', 'enPS2000ATriggerState', 'digital', 'enPS2000ATriggerState');
structs.tPS2000APwqConditions.packing=1;
structs.tPS2000APwqConditions.members=struct('channelA', 'enPS2000ATriggerState', 'channelB', 'enPS2000ATriggerState', 'channelC', 'enPS2000ATriggerState', 'channelD', 'enPS2000ATriggerState', 'external', 'enPS2000ATriggerState', 'aux', 'enPS2000ATriggerState', 'digital', 'enPS2000ATriggerState');
structs.tPS2000ADigitalChannelDirections.packing=1;
structs.tPS2000ADigitalChannelDirections.members=struct('channel', 'enPS2000ADigitalChannel', 'direction', 'enPS2000ADigitalDirection');
structs.tPS2000ATriggerChannelProperties.packing=1;
structs.tPS2000ATriggerChannelProperties.members=struct('thresholdUpper', 'int16', 'thresholdUpperHysteresis', 'uint16', 'thresholdLower', 'int16', 'thresholdLowerHysteresis', 'uint16', 'channel', 'enPS2000AChannel', 'thresholdMode', 'enPS2000AThresholdMode');
enuminfo.enPS2000AHoldOffType=struct('PS2000A_TIME',0,'PS2000A_MAX_HOLDOFF_TYPE',1);
enuminfo.enPS2000AThresholdMode=struct('PS2000A_LEVEL',0,'PS2000A_WINDOW',1);
enuminfo.enPS2000AWaveType=struct('PS2000A_SINE',0,'PS2000A_SQUARE',1,'PS2000A_TRIANGLE',2,'PS2000A_RAMP_UP',3,'PS2000A_RAMP_DOWN',4,'PS2000A_SINC',5,'PS2000A_GAUSSIAN',6,'PS2000A_HALF_SINE',7,'PS2000A_DC_VOLTAGE',8,'PS2000A_MAX_WAVE_TYPES',9);
enuminfo.enPS2000ARatioMode=struct('PS2000A_RATIO_MODE_NONE',0,'PS2000A_RATIO_MODE_AGGREGATE',1,'PS2000A_RATIO_MODE_DECIMATE',2,'PS2000A_RATIO_MODE_AVERAGE',4);
enuminfo.enPS2000AEtsMode=struct('PS2000A_ETS_OFF',0,'PS2000A_ETS_FAST',1,'PS2000A_ETS_SLOW',2,'PS2000A_ETS_MODES_MAX',3);
enuminfo.enPS2000AChannelBufferIndex=struct('PS2000A_CHANNEL_A_MAX',0,'PS2000A_CHANNEL_A_MIN',1,'PS2000A_CHANNEL_B_MAX',2,'PS2000A_CHANNEL_B_MIN',3,'PS2000A_CHANNEL_C_MAX',4,'PS2000A_CHANNEL_C_MIN',5,'PS2000A_CHANNEL_D_MAX',6,'PS2000A_CHANNEL_D_MIN',7,'PS2000A_MAX_CHANNEL_BUFFERS',8);
enuminfo.enPS2000AChannelInfo=struct('PS2000A_CI_RANGES',0);
enuminfo.enPS2000ARange=struct('PS2000A_10MV',0,'PS2000A_20MV',1,'PS2000A_50MV',2,'PS2000A_100MV',3,'PS2000A_200MV',4,'PS2000A_500MV',5,'PS2000A_1V',6,'PS2000A_2V',7,'PS2000A_5V',8,'PS2000A_10V',9,'PS2000A_20V',10,'PS2000A_50V',11,'PS2000A_MAX_RANGES',12);
enuminfo.enPS2000APulseWidthType=struct('PS2000A_PW_TYPE_NONE',0,'PS2000A_PW_TYPE_LESS_THAN',1,'PS2000A_PW_TYPE_GREATER_THAN',2,'PS2000A_PW_TYPE_IN_RANGE',3,'PS2000A_PW_TYPE_OUT_OF_RANGE',4);
enuminfo.enPS2000ATriggerOperand=struct('PS2000A_OPERAND_NONE',0,'PS2000A_OPERAND_OR',1,'PS2000A_OPERAND_AND',2,'PS2000A_OPERAND_THEN',3);
enuminfo.enPS2000ASigGenTrigType=struct('PS2000A_SIGGEN_RISING',0,'PS2000A_SIGGEN_FALLING',1,'PS2000A_SIGGEN_GATE_HIGH',2,'PS2000A_SIGGEN_GATE_LOW',3);
enuminfo.enPS2000AThresholdDirection=struct('PS2000A_ABOVE',0,'PS2000A_BELOW',1,'PS2000A_RISING',2,'PS2000A_FALLING',3,'PS2000A_RISING_OR_FALLING',4,'PS2000A_ABOVE_LOWER',5,'PS2000A_BELOW_LOWER',6,'PS2000A_RISING_LOWER',7,'PS2000A_FALLING_LOWER',8,'PS2000A_INSIDE',0,'PS2000A_OUTSIDE',1,'PS2000A_ENTER',2,'PS2000A_EXIT',3,'PS2000A_ENTER_OR_EXIT',4,'PS2000A_POSITIVE_RUNT',9,'PS2000A_NEGATIVE_RUNT',10,'PS2000A_NONE',2);
enuminfo.enPS2000ADigitalDirection=struct('PS2000A_DIGITAL_DONT_CARE',0,'PS2000A_DIGITAL_DIRECTION_LOW',1,'PS2000A_DIGITAL_DIRECTION_HIGH',2,'PS2000A_DIGITAL_DIRECTION_RISING',3,'PS2000A_DIGITAL_DIRECTION_FALLING',4,'PS2000A_DIGITAL_DIRECTION_RISING_OR_FALLING',5,'PS2000A_DIGITAL_MAX_DIRECTION',6);
enuminfo.enPS2000AIndexMode=struct('PS2000A_SINGLE',0,'PS2000A_DUAL',1,'PS2000A_QUAD',2,'PS2000A_MAX_INDEX_MODES',3);
enuminfo.enPS2000ACoupling=struct('PS2000A_AC',0,'PS2000A_DC',1);
enuminfo.enPS2000ASigGenTrigSource=struct('PS2000A_SIGGEN_NONE',0,'PS2000A_SIGGEN_SCOPE_TRIG',1,'PS2000A_SIGGEN_AUX_IN',2,'PS2000A_SIGGEN_EXT_IN',3,'PS2000A_SIGGEN_SOFT_TRIG',4);
enuminfo.enPS2000AChannel=struct('PS2000A_CHANNEL_A',0,'PS2000A_CHANNEL_B',1,'PS2000A_CHANNEL_C',2,'PS2000A_CHANNEL_D',3,'PS2000A_EXTERNAL',4,'PS2000A_MAX_CHANNELS',4,'PS2000A_TRIGGER_AUX',5,'PS2000A_MAX_TRIGGER_SOURCES',6);
enuminfo.enPS2000ADigitalPort=struct('PS2000A_DIGITAL_PORT0',128,'PS2000A_DIGITAL_PORT1',129,'PS2000A_DIGITAL_PORT2',130,'PS2000A_DIGITAL_PORT3',131,'PS2000A_MAX_DIGITAL_PORTS',4);
enuminfo.enPS2000ASweepType=struct('PS2000A_UP',0,'PS2000A_DOWN',1,'PS2000A_UPDOWN',2,'PS2000A_DOWNUP',3,'PS2000A_MAX_SWEEP_TYPES',4);
enuminfo.enPS2000AExtraOperations=struct('PS2000A_ES_OFF',0,'PS2000A_WHITENOISE',1,'PS2000A_PRBS',2);
enuminfo.enPS2000ATriggerState=struct('PS2000A_CONDITION_DONT_CARE',0,'PS2000A_CONDITION_TRUE',1,'PS2000A_CONDITION_FALSE',2,'PS2000A_CONDITION_MAX',3);
enuminfo.enPS2000ADigitalChannel=struct('PS2000A_DIGITAL_CHANNEL_0',0,'PS2000A_DIGITAL_CHANNEL_1',1,'PS2000A_DIGITAL_CHANNEL_2',2,'PS2000A_DIGITAL_CHANNEL_3',3,'PS2000A_DIGITAL_CHANNEL_4',4,'PS2000A_DIGITAL_CHANNEL_5',5,'PS2000A_DIGITAL_CHANNEL_6',6,'PS2000A_DIGITAL_CHANNEL_7',7,'PS2000A_DIGITAL_CHANNEL_8',8,'PS2000A_DIGITAL_CHANNEL_9',9,'PS2000A_DIGITAL_CHANNEL_10',10,'PS2000A_DIGITAL_CHANNEL_11',11,'PS2000A_DIGITAL_CHANNEL_12',12,'PS2000A_DIGITAL_CHANNEL_13',13,'PS2000A_DIGITAL_CHANNEL_14',14,'PS2000A_DIGITAL_CHANNEL_15',15,'PS2000A_DIGITAL_CHANNEL_16',16,'PS2000A_DIGITAL_CHANNEL_17',17,'PS2000A_DIGITAL_CHANNEL_18',18,'PS2000A_DIGITAL_CHANNEL_19',19,'PS2000A_DIGITAL_CHANNEL_20',20,'PS2000A_DIGITAL_CHANNEL_21',21,'PS2000A_DIGITAL_CHANNEL_22',22,'PS2000A_DIGITAL_CHANNEL_23',23,'PS2000A_DIGITAL_CHANNEL_24',24,'PS2000A_DIGITAL_CHANNEL_25',25,'PS2000A_DIGITAL_CHANNEL_26',26,'PS2000A_DIGITAL_CHANNEL_27',27,'PS2000A_DIGITAL_CHANNEL_28',28,'PS2000A_DIGITAL_CHANNEL_29',29,'PS2000A_DIGITAL_CHANNEL_30',30,'PS2000A_DIGITAL_CHANNEL_31',31,'PS2000A_MAX_DIGITAL_CHANNELS',32);
enuminfo.enPS2000ATimeUnits=struct('PS2000A_FS',0,'PS2000A_PS',1,'PS2000A_NS',2,'PS2000A_US',3,'PS2000A_MS',4,'PS2000A_S',5,'PS2000A_MAX_TIME_UNITS',6);
methodinfo=fcns;
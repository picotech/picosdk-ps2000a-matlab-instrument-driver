%% PS2000aConfig
% Configures paths according to platforms and loads information from
% prototype files for PicoScope 2000 Series (A API) Oscilloscopes. The folder 
% that this file is located in must be added to the MATLAB path.
%
% *Platform Specific Information:-*
%
% Microsoft Windows: Download the Software Development Kit installer from
% the <https://www.picotech.com/downloads Pico Technology Download software and manuals for oscilloscopes and data loggers> page.
% 
% Linux: Follow the instructions to install the libps2000a and libpswrappers
% packages from the <https://www.picotech.com/downloads/linux Pico Technology Linux Software & Drivers for Oscilloscopes and Data Loggers> page.
%
% Apple Mac OS X: Follow the instructions to install the PicoScope 6
% application from the <https://www.picotech.com/downloads Pico Technology Download software and manuals for oscilloscopes and data loggers> page.
% Optionally, create a |maci64| folder in the same directory as this file
% and copy the following files into it:
%
% * libps2000a.dylib and any other libps2000a library files
% * libps2000aWrap.dylib and any other libps2000aWrap library files
% * libpicoipp.dylib and any other libpicoipp library files
% * libiomp5.dylib
%
% Contact our Technical Support team via the <https://www.picotech.com/tech-support Technical Enquiries form> for further assistance.
%
% Run this script in the MATLAB environment prior to connecting to the 
% device.
%
% This file can be edited to suit application requirements.
%
% Copyright: © 2013-2017 Pico Technology Ltd. See LICENSE file for terms.	

%% Set Path to Shared Libraries, Prototype and Thunk Files
% Set paths to shared library files, prototype and thunk files according to
% the operating system and architecture.

% Identify working directory
ps2000aConfigInfo.workingDir = pwd;

% Find file name
ps2000aConfigInfo.configFileName = mfilename('fullpath');

% Only require the path to the config file
[ps2000aConfigInfo.pathStr] = fileparts(ps2000aConfigInfo.configFileName);

% Identify architecture e.g. 'win64'
ps2000aConfigInfo.archStr = computer('arch');
ps2000aConfigInfo.archPath = fullfile(ps2000aConfigInfo.pathStr, ps2000aConfigInfo.archStr);

% Add path to Prototype and Thunk files if not already present
if (isempty(strfind(path, ps2000aConfigInfo.archPath)))
    
    try

        addpath(ps2000aConfigInfo.archPath);

    catch err

        error('PS2000aConfig:OperatingSystemNotSupported', ...
            'Operating system not supported - please contact support@picotech.com');

    end
    
end

% Set the path to drivers according to operating system.

% Define possible paths for drivers - edit to specify location of drivers

ps2000aConfigInfo.macDriverPath = '/Applications/PicoScope6.app/Contents/Resources/lib';
ps2000aConfigInfo.linuxDriverPath = '/opt/picoscope/lib/';

ps2000aConfigInfo.winSDKInstallPath = 'C:\Program Files\Pico Technology\SDK';
ps2000aConfigInfo.winDriverPath = fullfile(ps2000aConfigInfo.winSDKInstallPath, 'lib');

%32-bit version of MATLAB on Windows 64-bit
ps2000aConfigInfo.woW64SDKInstallPath = 'C:\Program Files (x86)\Pico Technology\SDK'; 
ps2000aConfigInfo.woW64DriverPath = fullfile(ps2000aConfigInfo.woW64SDKInstallPath, 'lib');

if (ismac())
    
    % Libraries (including wrapper libraries) are stored in the PicoScope
    % 6 App folder. Add locations of library files to environment variable.
    
    setenv('DYLD_LIBRARY_PATH', ps2000aConfigInfo.macDriverPath);
    
    if (strfind(getenv('DYLD_LIBRARY_PATH'), ps2000aConfigInfo.macDriverPath))
        
        % Add path to drivers if not already on the MATLAB path
        if (isempty(strfind(path, ps2000aConfigInfo.macDriverPath)))
        
            addpath(ps2000aConfigInfo.macDriverPath);
            
        end
        
    else
        
        warning('PS2000aConfig:LibraryPathNotFound','Locations of libraries not found in DYLD_LIBRARY_PATH');
        
    end
    
elseif (isunix())
    
    % Add path to drivers if not already on the MATLAB path
    if (isempty(strfind(path, ps2000aConfigInfo.linuxDriverPath)))
        
        addpath(ps2000aConfigInfo.linuxDriverPath);
            
    end
		
elseif (ispc())
    
    % Microsoft Windows operating systems
    
    % Set path to dll files if the Pico Technology SDK Installer has been
    % used or place dll files in the folder corresponding to the
    % architecture. Detect if 32-bit version of MATLAB on 64-bit Microsoft
    % Windows.
    
    ps2000aConfigInfo.winSDKInstallPath = '';
    
    if (strcmp(ps2000aConfigInfo.archStr, 'win32') && exist('C:\Program Files (x86)\', 'dir') == 7)
        
        % Add path to drivers if not already on the MATLAB path
        if (isempty(strfind(path, ps2000aConfigInfo.woW64DriverPath)))
        
            try
                
                addpath(ps2000aConfigInfo.woW64DriverPath);
                
            catch err
           
                warning('PS2000aConfig:DirectoryNotFound', ['Folder C:\Program Files (x86)\Pico Technology\SDK\lib\ not found. '...
                'Please ensure that the location of the library files are on the MATLAB path.']);
            
            end
            
        end
            
    else
        
        % 32-bit MATLAB on 32-bit Windows or 64-bit MATLAB on 64-bit
        % Windows operating systems
        
        % Add path to drivers if not already on the MATLAB path
        if (isempty(strfind(path, ps2000aConfigInfo.winDriverPath)))
            
            try 

                addpath(ps2000aConfigInfo.winDriverPath);

            catch err

                warning('PS2000aConfig:DirectoryNotFound', ['Folder C:\Program Files\Pico Technology\SDK\lib\ not found. '...
                    'Please ensure that the location of the library files are on the MATLAB path.']);

            end
            
        end
        
    end
    
else
    
    error('PS2000aConfig:OperatingSystemNotSupported', 'Operating system not supported - please contact support@picotech.com');
    
end

%% Set Path for PicoScope Support Toolbox Files if not Installed
% Set MATLAB Path to include location of PicoScope Support Toolbox
% Functions and Classes if the Toolbox has not been installed. Installation
% of the toolbox is only supported in MATLAB 2014b and later versions.
%
% Check if PicoScope Support Toolbox is installed - using code based on
% <http://stackoverflow.com/questions/6926021/how-to-check-if-matlab-toolbox-installed-in-matlab How to check if matlab toolbox installed in matlab>

ps2000aConfigInfo.psTbxName = 'PicoScope Support Toolbox';
ps2000aConfigInfo.v = ver; % Find installed toolbox information

if (~any(strcmp(ps2000aConfigInfo.psTbxName, {ps2000aConfigInfo.v.Name})))
   
    warning('PS2000aConfig:PSTbxNotFound', 'PicoScope Support Toolbox not found, searching for folder.');
    
    % If the PicoScope Support Toolbox has not been installed, check to see
    % if the folder is on the MATLAB path, having been downloaded via zip
    % file.
    
    ps2000aConfigInfo.psTbxFound = strfind(path, ps2000aConfigInfo.psTbxName);
    
    if (isempty(ps2000aConfigInfo.psTbxFound))
        
        ps2000aConfigInfo.psTbxNotFoundWarningMsg = sprintf(['Please install the PicoScope Support Toolbox '...
            'via the Add-Ons Explorer or download the zip file from MATLAB Central File Exchange ' ...
            'and add the location of the extracted contents to the MATLAB path.']);
        
        warning('PS2000aConfig:PSTbxDirNotFound', ps2000aConfigInfo.psTbxNotFoundWarningMsg);
        
        ps2000aConfigInfo.f = warndlg(ps2000aConfigInfo.psTbxNotFoundWarningMsg, 'PicoScope Support Toolbox Not Found', 'modal');
        uiwait(ps2000aConfigInfo.f);
        
        web('https://uk.mathworks.com/matlabcentral/fileexchange/53681-picoscope-support-toolbox');
            
    end
    
end

% Change back to the folder where the script was called from.
cd(ps2000aConfigInfo.workingDir);

%% Load Enumerations and Structure Information
% Enumerations and structures are used by certain Intrument Driver functions.

% Find prototype file names based on architecture

ps2000aConfigInfo.ps2000aMFile = str2func(strcat('ps2000aMFile_', ps2000aConfigInfo.archStr));
ps2000aConfigInfo.ps2000aWrapMFile = str2func(strcat('ps2000aWrapMFile_', ps2000aConfigInfo.archStr));

[ps2000aMethodinfo, ps2000aStructs, ps2000aEnuminfo, ps2000aThunkLibName] = ps2000aConfigInfo.ps2000aMFile(); 

[ps2000aWrapMethodinfo, ps2000aWrapStructs, ps2000aWrapEnuminfo, ps2000aWrapThunkLibName] = ps2000aConfigInfo.ps2000aWrapMFile();

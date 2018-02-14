%% PS2000aSetup 
% Checks for prerequisites and prompts User to install the relevant
% dependencies if not already installed.

    % Download SDK

    % Windows
    
        % Check for presence of SDK otherwise prompt to download
    
    % Linux
    
        % Check if driver location is present otherwise prompt to install
        % using instructions
    
    % Mac OS X
    
        % Check for PicoScope 6 install
    
%% Download PicoScope Support Toolbox if not Installed

    ps2000aSetup.psTbxName = 'PicoScope Support Toolbox';
    ps2000aSetup.v = ver; % Find installed toolbox information

    if (~any(strcmp(ps2000aSetup.psTbxName, {ps2000aSetup.v.Name})))
       
        % Download Toolbox file if MATLAB 2014b or later
        
        
        % Down
        
    end



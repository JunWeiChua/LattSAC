classdef SaveSAC_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        NameLatt            matlab.ui.control.EditField
        SaveDataButton      matlab.ui.control.Button
        CancelButton        matlab.ui.control.Button
        NameofSACPlotLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
        ParentApp           % Main app object
        Lattice             % Lattice Structure
        Name                % Name of Lattice Structure
    end
    
    methods (Access = private)
        
        function saveSACData(app)
            % Frequency against SAC
            filename = strcat(app.Name,'_SAC.txt');
            fileID = fopen(filename,'w');

            fprintf(fileID,'Frequency\tSAC\n');
            for idx = 1:length(app.Lattice.Frequency)
                fprintf(fileID,'%d\t%.6f\n', ...
                    app.Lattice.Frequency(idx), ...
                    app.Lattice.SAC(idx));
            end
            fclose(fileID);

            % Mean, Std and NRC stats.
            filename = strcat(app.Name,'_stats.txt');
            fileID = fopen(filename,'w');

            fprintf(fileID,'Name of Lattice: %s\n',app.Name);
            fprintf(fileID,'Mean SAC:        %.6f\n', ...
                app.ParentApp.MeanSACEditField.Value);
            fprintf(fileID,'StdDev SAC:      %.6f\n', ...
                app.ParentApp.StdDevSACEditField.Value);
            fprintf(fileID,'NRC:             %.6f\n', ...
                app.ParentApp.NRCEditField.Value);
            fprintf(fileID,'500 - 1000 Hz:   %.6f\n', ...
                app.ParentApp.FreqBand_1.Value);
            fprintf(fileID,'1000 - 2000 Hz:  %.6f\n', ...
                app.ParentApp.FreqBand_2.Value);
            fprintf(fileID,'2000 - 4000 Hz:  %.6f\n', ...
                app.ParentApp.FreqBand_3.Value);
            fprintf(fileID,'4000 - 6300 Hz:  %.6f\n', ...
                app.ParentApp.FreqBand_4.Value);
            
            fclose(fileID);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, MainApp, LatticeStructure)
            % Store main app in property for CloseRequestFcn to use
            app.ParentApp = MainApp;
            
            % Update UI with input values
            app.Lattice = LatticeStructure;
            app.Name = [];
        end

        % Value changed function: NameLatt
        function NameLattValueChanged(app, event)
            value = app.NameLatt.Value;
            app.Name = value;
        end

        % Button pushed function: SaveDataButton
        function SaveDataButtonPushed(app, event)
            if ~isempty(app.Name)
                filename = strcat(app.Name,".png");
                exportgraphics(app.ParentApp.UIAxes,filename,"Resolution",500);
                app.saveSACData();
    
                % Delete the dialog box
                delete(app);
            end
        end

        % Button pushed function: CancelButton
        function CancelButtonPushed(app, event)
            % Delete the dialog box
            delete(app);
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            % Delete the dialog box
            delete(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 400 210];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create NameofSACPlotLabel
            app.NameofSACPlotLabel = uilabel(app.UIFigure);
            app.NameofSACPlotLabel.HorizontalAlignment = 'center';
            app.NameofSACPlotLabel.FontSize = 24;
            app.NameofSACPlotLabel.FontWeight = 'bold';
            app.NameofSACPlotLabel.Position = [52 130 301 31];
            app.NameofSACPlotLabel.Text = 'Name of Lattice Structure';

            % Create CancelButton
            app.CancelButton = uibutton(app.UIFigure, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [254 40 100 28];
            app.CancelButton.Text = 'Cancel';

            % Create SaveDataButton
            app.SaveDataButton = uibutton(app.UIFigure, 'push');
            app.SaveDataButton.ButtonPushedFcn = createCallbackFcn(app, @SaveDataButtonPushed, true);
            app.SaveDataButton.FontSize = 16;
            app.SaveDataButton.Position = [53 40 120 28];
            app.SaveDataButton.Text = 'Save Data';

            % Create NameLatt
            app.NameLatt = uieditfield(app.UIFigure, 'text');
            app.NameLatt.CharacterLimits = [0 40];
            app.NameLatt.ValueChangedFcn = createCallbackFcn(app, @NameLattValueChanged, true);
            app.NameLatt.FontSize = 24;
            app.NameLatt.Position = [53 85 300 35];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SaveSAC_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
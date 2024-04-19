classdef SaveLatt_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure           matlab.ui.Figure
        NameLatt           matlab.ui.control.EditField
        SaveLatticeButton  matlab.ui.control.Button
        CancelButton       matlab.ui.control.Button
        NameofLatticeStructureEditFieldLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
        ParentApp           % Main app object
        Name                % Name of Lattice Structure
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, MainApp)
            % Store main app in property for CloseRequestFcn to use
            app.ParentApp = MainApp;
            
            % Update UI with input values
            app.Name = [];
        end

        % Value changed function: NameLatt
        function NameLattValueChanged(app, event)
            value = app.NameLatt.Value;
            app.Name = value;
        end

        % Button pushed function: SaveLatticeButton
        function SaveLatticeButtonPushed(app, event)
            if ~isempty(app.Name)
                app.ParentApp.saveLatt(app.Name);
            end
            
            % Delete the dialog box
            delete(app);
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

            % Create NameofLatticeStructureEditFieldLabel
            app.NameofLatticeStructureEditFieldLabel = uilabel(app.UIFigure);
            app.NameofLatticeStructureEditFieldLabel.HorizontalAlignment = 'center';
            app.NameofLatticeStructureEditFieldLabel.FontSize = 24;
            app.NameofLatticeStructureEditFieldLabel.FontWeight = 'bold';
            app.NameofLatticeStructureEditFieldLabel.Position = [52 130 300 31];
            app.NameofLatticeStructureEditFieldLabel.Text = 'Name of Lattice Structure';

            % Create CancelButton
            app.CancelButton = uibutton(app.UIFigure, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [254 40 100 28];
            app.CancelButton.Text = 'Cancel';

            % Create SaveLatticeButton
            app.SaveLatticeButton = uibutton(app.UIFigure, 'push');
            app.SaveLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLatticeButtonPushed, true);
            app.SaveLatticeButton.FontSize = 16;
            app.SaveLatticeButton.Position = [53 40 120 28];
            app.SaveLatticeButton.Text = 'Save Lattice';

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
        function app = SaveLatt_exported(varargin)

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
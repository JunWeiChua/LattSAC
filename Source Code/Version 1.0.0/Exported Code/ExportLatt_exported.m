classdef ExportLatt_exported < matlab.apps.AppBase

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
        Lattice             % Lattice Structure
        Name                % Name of Lattice Structure
    end
    
    methods (Access = private)
        
        function exportLattice(app)
            filename = strcat(app.Name,'.txt');
            fileID = fopen(filename,'w');

            fprintf(fileID,'Name of Lattice:    %s\n',app.Name);
            fprintf(fileID,'Cross Section:      %s\n',app.Lattice.CrossSection);
            fprintf(fileID,'Sample Diameter:    %d\n',app.Lattice.l_sample);
            fprintf(fileID,'Number of Layers:   %d\n',app.Lattice.num_layers);
            fprintf(fileID,'\n');
            cur = app.Lattice.Head; count = 1;
            while ~isempty(cur)
                fprintf(fileID,'Layer Number:       %d\n',count);
                app.showLattLayer(cur.Data,fileID);
                cur = cur.Next; count = count + 1;
            end
            fclose(fileID);
        end

        function showLattLayer(~,layer,fileID)
            fprintf(fileID,'Number of Parts:    %d\n',layer.Length);
            cur = layer.Head; count = 1;
            while ~isempty(cur)
                part = cur.Data;
                fprintf(fileID,'Part Number:        %d\n',count);
                fprintf(fileID,'Unit Cell:          %s\n',part.UnitCell.CellArch.Name);
                fprintf(fileID,'Cell Type:          %s\n',part.UnitCell.CellArch.CellType);
			    fprintf(fileID,'Cell Length:	    %.5f\n',part.UnitCell.cell_length);
			    fprintf(fileID,'Rel Density:	    %.5f\n',part.UnitCell.rel_density);
			    fprintf(fileID,'Strut Length:	    %.5f\n',part.UnitCell.strut_length);
			    fprintf(fileID,'Strut Width:	    %.5f\n',part.UnitCell.strut_width);
			    fprintf(fileID,'Number of layers:   %d\n',part.N_z);
                fprintf(fileID,'Surface Ratio:	    %.3f\n',part.SurfaceRatio);
                fprintf(fileID,'\n');
                cur = cur.Next; count = count + 1;
            end
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

        % Button pushed function: SaveLatticeButton
        function SaveLatticeButtonPushed(app, event)
            app.exportLattice();
            
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
            app.exportLattice();

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
        function app = ExportLatt_exported(varargin)

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
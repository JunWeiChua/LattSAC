classdef LoadLatt_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        DeleteLatticeButton     matlab.ui.control.Button
        LoadLatticeDesignPanel  matlab.ui.container.Panel
        UITable                 matlab.ui.control.Table
        LoadLatticeButton       matlab.ui.control.Button
        CancelButton            matlab.ui.control.Button
    end

    
    properties (Access = private)
        ParentApp           % Main app object
        LattLibrary         % Library of example Lattice Objects
        LattLibraryLabel    % Library of example Lattice Objects
        LattLibraryTable    % Table containing LattLibrary
        SelectedLattice     % Lattice seclected
        RowNumber           % Selected Row Number
    end
    
    methods (Access = private)
        
        function setDefaults(app)
            % Set default properties
            app.SelectedLattice = [];
            app.RowNumber = 0;
            app.showTable();
        end

        function showTable(app)
            % Create new LattLayerPartTable.
            app.LattLibraryTable = [];
            app.LattLibraryTable = table('Size',[0 3],...
                'VariableTypes',["string","double","double"], ...
                'VariableNames',["Name","Thickness","Mean SAC"]);
            
            % Add rows for LattLayerPartTable.
            cur = app.LattLibrary.Head;
            while ~isempty(cur)
                latt = cur.Data;
                node = app.LattLibraryLabel.getNode(cur.Index);
                app.LattLibraryTable(cur.Index,:) = ...
                    {node.Data,latt.t_sample,mean(latt.SAC)};
                cur = cur.Next;
            end
            
            % Show LattLayerPartTable on UI.
            app.UITable.Data = app.LattLibraryTable;
            app.UITable.RowName = 'numbered';
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, MainApp, LattLib, LattLabel)
            % Store main app in property for CloseRequestFcn to use
            app.ParentApp = MainApp;
            app.LattLibrary = LattLib;
            app.LattLibraryLabel = LattLabel;

            % Set app defaults.
            app.setDefaults();
        end

        % Clicked callback: UITable
        function UITableClicked(app, event)
            displayRow = event.InteractionInformation.DisplayRow;
            node = app.LattLibrary.getNode(displayRow);
            app.SelectedLattice = node.Data;
            app.RowNumber = displayRow;
        end

        % Button pushed function: LoadLatticeButton
        function LoadLatticeButtonPushed(app, event)
            if ~isempty(app.SelectedLattice)
                % Update the LatticeStructure in the main app.
                app.ParentApp.loadLatt(app.SelectedLattice);
            end
            
            % Delete the dialog box
            delete(app);
        end

        % Button pushed function: DeleteLatticeButton
        function DeleteLatticeButtonPushed(app, event)
            if app.RowNumber > 0
                app.LattLibrary.remove(app.RowNumber);
                app.LattLibraryLabel.remove(app.RowNumber);
                app.showTable();

                app.ParentApp.updateLattLib(app.LattLibrary,app.LattLibraryLabel);
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
            app.UIFigure.Position = [100 100 480 360];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create CancelButton
            app.CancelButton = uibutton(app.UIFigure, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [370 8 100 28];
            app.CancelButton.Text = 'Cancel';

            % Create LoadLatticeButton
            app.LoadLatticeButton = uibutton(app.UIFigure, 'push');
            app.LoadLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @LoadLatticeButtonPushed, true);
            app.LoadLatticeButton.FontSize = 16;
            app.LoadLatticeButton.Position = [10 8 100 28];
            app.LoadLatticeButton.Text = 'Load Lattice';

            % Create LoadLatticeDesignPanel
            app.LoadLatticeDesignPanel = uipanel(app.UIFigure);
            app.LoadLatticeDesignPanel.BorderWidth = 2;
            app.LoadLatticeDesignPanel.TitlePosition = 'centertop';
            app.LoadLatticeDesignPanel.Title = 'Load Lattice Design';
            app.LoadLatticeDesignPanel.BackgroundColor = [1 1 1];
            app.LoadLatticeDesignPanel.FontWeight = 'bold';
            app.LoadLatticeDesignPanel.FontSize = 20;
            app.LoadLatticeDesignPanel.Position = [2 46 480 315];

            % Create UITable
            app.UITable = uitable(app.LoadLatticeDesignPanel);
            app.UITable.ColumnName = {'Name'; 'Thickness'; 'Mean SAC'};
            app.UITable.RowName = {};
            app.UITable.SelectionType = 'row';
            app.UITable.ClickedFcn = createCallbackFcn(app, @UITableClicked, true);
            app.UITable.Multiselect = 'off';
            app.UITable.FontSize = 16;
            app.UITable.Position = [5 5 470 270];

            % Create DeleteLatticeButton
            app.DeleteLatticeButton = uibutton(app.UIFigure, 'push');
            app.DeleteLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteLatticeButtonPushed, true);
            app.DeleteLatticeButton.FontSize = 16;
            app.DeleteLatticeButton.Position = [182 8 120 28];
            app.DeleteLatticeButton.Text = 'Delete Lattice';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LoadLatt_exported(varargin)

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
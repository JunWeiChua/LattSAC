classdef LattPartProp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        LatticeLayerPartPropertiesPanel  matlab.ui.container.Panel
        UnitCellDropDown            matlab.ui.control.DropDown
        CellSizemmSliderLabel       matlab.ui.control.Label
        CellSizemmSlider            matlab.ui.control.Slider
        CellSizeNumeric             matlab.ui.control.NumericEditField
        RelativeDensitySliderLabel  matlab.ui.control.Label
        RelativeDensitySlider       matlab.ui.control.Slider
        RelativeDensityNumeric      matlab.ui.control.NumericEditField
        NumberofLayersSpinner       matlab.ui.control.Spinner
        SurfaceRatioSliderLabel     matlab.ui.control.Label
        SurfaceRatioSlider          matlab.ui.control.Slider
        SurfaceRatioNumeric         matlab.ui.control.NumericEditField
        NumberofLayersSpinnerLabel  matlab.ui.control.Label
        UnitCellDropDownLabel       matlab.ui.control.Label
        SaveLayerPartButton         matlab.ui.control.Button
        ResetPartButton             matlab.ui.control.Button
        CancelButton                matlab.ui.control.Button
    end

    
    properties (Access = private)
        ParentApp       % Main app object
        CurPart         % Current LattLayerPart to change (LattLayerPart)
        NewPart         % New LattLayerPart to be used.
        UnitCell        % Unit Cells
        CellSize        % Cell Size
        RD              % Relative Density
        SurfaceRatio    % Surface Ratio of Part
    end
    
    methods (Access = private)
        
        function setDefaults(app)
            % Set default properties
            app.UnitCellDropDown.Items = app.UnitCell;

            app.CellSizemmSlider.Limits = [app.CellSize(1),app.CellSize(end)];
            app.CellSizemmSlider.MajorTicks = 4:1:8;
            app.CellSizemmSlider.MinorTicks = 4:0.2:8;
            
            app.RelativeDensitySlider.Limits = [app.RD(1),app.RD(end)];
            app.RelativeDensitySlider.MajorTicks = 0.1:0.1:0.4;
            app.RelativeDensitySlider.MinorTicks = 0.1:0.02:0.4;

            app.SurfaceRatio = 0:0.01:1;
            app.SurfaceRatioSlider.Limits = [app.SurfaceRatio(1),app.SurfaceRatio(end)];
            app.SurfaceRatioSlider.MajorTicks = 0:0.2:1;
            app.SurfaceRatioSlider.MinorTicks = 0:0.05:1;

            app.initialisePart();
        end
        
        % Initialise lattice layer part.
        function initialisePart(app)
            app.showPart(app.CurPart);
            app.NewPart = app.CurPart.copyPart();
        end

        % Show lattice layer parameters on app.
        function showPart(app,part)
            if nargin == 2
                app.UnitCellDropDown.Value = part.UnitCell.CellArch.Name;
                app.CellSizemmSlider.Value = part.UnitCell.cell_length;
                app.RelativeDensitySlider.Value = part.UnitCell.rel_density;
                app.NumberofLayersSpinner.Value = part.N_z;
                app.SurfaceRatioSlider.Value = part.SurfaceRatio;

                app.CellSizeNumeric.Value = app.CellSizemmSlider.Value;
                app.RelativeDensityNumeric.Value = app.RelativeDensitySlider.Value;
                app.SurfaceRatioNumeric.Value = app.SurfaceRatioSlider.Value;
            else
                app.defaultPart();
            end
        end

        % Default layer properties
        function defaultPart(app)
            app.UnitCellDropDown.Value = app.UnitCellDropDown.Items(1);
            app.CellSizemmSlider.Value = mean(app.CellSizemmSlider.Limits);
            app.RelativeDensitySlider.Value = 0.3;
            app.NumberofLayersSpinner.Value = 1;
            app.SurfaceRatioSlider.Value = 1;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, MainApp, LattPart, CellArch, CellSize, RD)
            % Store main app in property for CloseRequestFcn to use
            app.ParentApp = MainApp;
            
            % Update UI with input values
            app.CurPart = LattPart;
            app.UnitCell = CellArch;
            app.CellSize = CellSize;
            app.RD = RD;

            % Set app defaults.
            app.setDefaults();
        end

        % Value changed function: UnitCellDropDown
        function UnitCellDropDownValueChanged(app, event)
            value = app.UnitCellDropDown.Value;
            app.NewPart.changeUC(value);
        end

        % Value changed function: CellSizemmSlider
        function CellSizemmSliderValueChanged(app, event)
            value = app.CellSizemmSlider.Value;
            app.CellSizeNumeric.Value = value;
            app.NewPart.UnitCell.setLcell(value);
            app.NewPart.updateXYZ();
        end

        % Value changed function: RelativeDensitySlider
        function RelativeDensitySliderValueChanged(app, event)
            value = app.RelativeDensitySlider.Value;
            app.RelativeDensityNumeric.Value = value;
            app.NewPart.UnitCell.setRD(value);
        end

        % Value changed function: NumberofLayersSpinner
        function NumberofLayersSpinnerValueChanged(app, event)
            value = app.NumberofLayersSpinner.Value;
            app.NewPart.setNz(value);
        end

        % Value changed function: SurfaceRatioSlider
        function SurfaceRatioSliderValueChanged(app, event)
            value = app.SurfaceRatioSlider.Value;
            app.SurfaceRatioNumeric.Value = value;
            app.NewPart.setSR(value);
        end

        % Button pushed function: SaveLayerPartButton
        function SaveLayerPartButtonPushed(app, event)
            % Update the LattLayerPart in the main app.
            app.ParentApp.updatePart(app.NewPart);

            % Delete the dialog box
            delete(app);
        end

        % Button pushed function: ResetPartButton
        function ResetPartButtonPushed(app, event)
            % Initialise lattice layer part.
            app.initialisePart();
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
            app.UIFigure.Position = [100 100 400 300];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create CancelButton
            app.CancelButton = uibutton(app.UIFigure, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.FontSize = 16;
            app.CancelButton.Position = [290 8 100 28];
            app.CancelButton.Text = 'Cancel';

            % Create ResetPartButton
            app.ResetPartButton = uibutton(app.UIFigure, 'push');
            app.ResetPartButton.ButtonPushedFcn = createCallbackFcn(app, @ResetPartButtonPushed, true);
            app.ResetPartButton.FontSize = 16;
            app.ResetPartButton.Position = [170 8 100 28];
            app.ResetPartButton.Text = 'Reset Part';

            % Create SaveLayerPartButton
            app.SaveLayerPartButton = uibutton(app.UIFigure, 'push');
            app.SaveLayerPartButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLayerPartButtonPushed, true);
            app.SaveLayerPartButton.FontSize = 16;
            app.SaveLayerPartButton.Position = [10 8 140 28];
            app.SaveLayerPartButton.Text = 'Save Layer Part';

            % Create LatticeLayerPartPropertiesPanel
            app.LatticeLayerPartPropertiesPanel = uipanel(app.UIFigure);
            app.LatticeLayerPartPropertiesPanel.BorderWidth = 2;
            app.LatticeLayerPartPropertiesPanel.TitlePosition = 'centertop';
            app.LatticeLayerPartPropertiesPanel.Title = 'Lattice Layer Part Properties';
            app.LatticeLayerPartPropertiesPanel.BackgroundColor = [1 1 1];
            app.LatticeLayerPartPropertiesPanel.FontWeight = 'bold';
            app.LatticeLayerPartPropertiesPanel.FontSize = 20;
            app.LatticeLayerPartPropertiesPanel.Position = [1 41 400 260];

            % Create UnitCellDropDownLabel
            app.UnitCellDropDownLabel = uilabel(app.LatticeLayerPartPropertiesPanel);
            app.UnitCellDropDownLabel.FontSize = 16;
            app.UnitCellDropDownLabel.Position = [10 203 65 22];
            app.UnitCellDropDownLabel.Text = 'Unit Cell';

            % Create NumberofLayersSpinnerLabel
            app.NumberofLayersSpinnerLabel = uilabel(app.LatticeLayerPartPropertiesPanel);
            app.NumberofLayersSpinnerLabel.FontSize = 16;
            app.NumberofLayersSpinnerLabel.Position = [10 61 132 22];
            app.NumberofLayersSpinnerLabel.Text = 'Number of Layers';

            % Create SurfaceRatioNumeric
            app.SurfaceRatioNumeric = uieditfield(app.LatticeLayerPartPropertiesPanel, 'numeric');
            app.SurfaceRatioNumeric.Limits = [0 1];
            app.SurfaceRatioNumeric.HorizontalAlignment = 'center';
            app.SurfaceRatioNumeric.FontSize = 16;
            app.SurfaceRatioNumeric.Position = [340 31 50 22];
            app.SurfaceRatioNumeric.Value = 0.5;

            % Create SurfaceRatioSlider
            app.SurfaceRatioSlider = uislider(app.LatticeLayerPartPropertiesPanel);
            app.SurfaceRatioSlider.Limits = [0 1];
            app.SurfaceRatioSlider.MajorTicks = [0 0.2 0.4 0.6 0.8 1];
            app.SurfaceRatioSlider.ValueChangedFcn = createCallbackFcn(app, @SurfaceRatioSliderValueChanged, true);
            app.SurfaceRatioSlider.MinorTicks = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
            app.SurfaceRatioSlider.FontSize = 16;
            app.SurfaceRatioSlider.Position = [160 40 170 3];
            app.SurfaceRatioSlider.Value = 0.5;

            % Create SurfaceRatioSliderLabel
            app.SurfaceRatioSliderLabel = uilabel(app.LatticeLayerPartPropertiesPanel);
            app.SurfaceRatioSliderLabel.FontSize = 16;
            app.SurfaceRatioSliderLabel.Position = [10 31 102 22];
            app.SurfaceRatioSliderLabel.Text = 'Surface Ratio';

            % Create NumberofLayersSpinner
            app.NumberofLayersSpinner = uispinner(app.LatticeLayerPartPropertiesPanel);
            app.NumberofLayersSpinner.Limits = [0 Inf];
            app.NumberofLayersSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofLayersSpinnerValueChanged, true);
            app.NumberofLayersSpinner.HorizontalAlignment = 'left';
            app.NumberofLayersSpinner.FontSize = 16;
            app.NumberofLayersSpinner.Position = [160 61 230 22];

            % Create RelativeDensityNumeric
            app.RelativeDensityNumeric = uieditfield(app.LatticeLayerPartPropertiesPanel, 'numeric');
            app.RelativeDensityNumeric.Limits = [0.1 0.4];
            app.RelativeDensityNumeric.HorizontalAlignment = 'center';
            app.RelativeDensityNumeric.FontSize = 16;
            app.RelativeDensityNumeric.Position = [340 117 50 22];
            app.RelativeDensityNumeric.Value = 0.3;

            % Create RelativeDensitySlider
            app.RelativeDensitySlider = uislider(app.LatticeLayerPartPropertiesPanel);
            app.RelativeDensitySlider.Limits = [0.1 0.4];
            app.RelativeDensitySlider.MajorTicks = [0.1 0.2 0.3 0.4];
            app.RelativeDensitySlider.ValueChangedFcn = createCallbackFcn(app, @RelativeDensitySliderValueChanged, true);
            app.RelativeDensitySlider.MinorTicks = [0.1 0.12 0.14 0.16 0.18 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4];
            app.RelativeDensitySlider.FontSize = 16;
            app.RelativeDensitySlider.Position = [160 126 170 3];
            app.RelativeDensitySlider.Value = 0.3;

            % Create RelativeDensitySliderLabel
            app.RelativeDensitySliderLabel = uilabel(app.LatticeLayerPartPropertiesPanel);
            app.RelativeDensitySliderLabel.FontSize = 16;
            app.RelativeDensitySliderLabel.Position = [10 117 121 22];
            app.RelativeDensitySliderLabel.Text = 'Relative Density';

            % Create CellSizeNumeric
            app.CellSizeNumeric = uieditfield(app.LatticeLayerPartPropertiesPanel, 'numeric');
            app.CellSizeNumeric.Limits = [4 8];
            app.CellSizeNumeric.HorizontalAlignment = 'center';
            app.CellSizeNumeric.FontSize = 16;
            app.CellSizeNumeric.Position = [340 173 50 22];
            app.CellSizeNumeric.Value = 6;

            % Create CellSizemmSlider
            app.CellSizemmSlider = uislider(app.LatticeLayerPartPropertiesPanel);
            app.CellSizemmSlider.Limits = [4 8];
            app.CellSizemmSlider.MajorTicks = [4 5 6 7 8];
            app.CellSizemmSlider.ValueChangedFcn = createCallbackFcn(app, @CellSizemmSliderValueChanged, true);
            app.CellSizemmSlider.MinorTicks = [4 4.2 4.4 4.6 4.8 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 7.2 7.4 7.6 7.8 8];
            app.CellSizemmSlider.FontSize = 16;
            app.CellSizemmSlider.Position = [160 182 170 3];
            app.CellSizemmSlider.Value = 6;

            % Create CellSizemmSliderLabel
            app.CellSizemmSliderLabel = uilabel(app.LatticeLayerPartPropertiesPanel);
            app.CellSizemmSliderLabel.FontSize = 16;
            app.CellSizemmSliderLabel.Position = [10 173 110 22];
            app.CellSizemmSliderLabel.Text = 'Cell Size (mm)';

            % Create UnitCellDropDown
            app.UnitCellDropDown = uidropdown(app.LatticeLayerPartPropertiesPanel);
            app.UnitCellDropDown.Items = {'SC-Truss', 'BCC-Truss', 'FCC-Truss'};
            app.UnitCellDropDown.ValueChangedFcn = createCallbackFcn(app, @UnitCellDropDownValueChanged, true);
            app.UnitCellDropDown.FontSize = 16;
            app.UnitCellDropDown.Position = [160 203 230 22];
            app.UnitCellDropDown.Value = 'SC-Truss';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LattPartProp_exported(varargin)

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
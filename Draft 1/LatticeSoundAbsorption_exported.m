classdef LatticeSoundAbsorption_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        LatticePropertiesPanel         matlab.ui.container.Panel
        CrossSectionDropDown           matlab.ui.control.DropDown
        LengthDiametermmSlider         matlab.ui.control.Slider
        NumberofDistinctLayersSpinner  matlab.ui.control.Spinner
        ThicknessmmEditField           matlab.ui.control.NumericEditField
        FrequencySpinner               matlab.ui.control.Spinner
        FrequencySpinnerLabel          matlab.ui.control.Label
        FrequencySpinnerLabel_2        matlab.ui.control.Label
        FrequencySpinnerLabel_3        matlab.ui.control.Label
        FrequencySpinner_2             matlab.ui.control.Spinner
        ThicknessmmEditFieldLabel      matlab.ui.control.Label
        NumberofDistinctLayersSpinnerLabel  matlab.ui.control.Label
        LengthDiametermmSliderLabel    matlab.ui.control.Label
        CrossSectionDropDownLabel      matlab.ui.control.Label
        LayerPanel                     matlab.ui.container.Panel
        NumberofLayersSpinnerLabel     matlab.ui.control.Label
        LayerNumberDropDown            matlab.ui.control.DropDown
        LayerNumberDropDownLabel       matlab.ui.control.Label
        UnitCellDropDown               matlab.ui.control.DropDown
        RelativeDensitySliderLabel     matlab.ui.control.Label
        CellSizemmSlider               matlab.ui.control.Slider
        CellSizemmSliderLabel          matlab.ui.control.Label
        RelativeDensitySlider          matlab.ui.control.Slider
        NumberofLayersSpinner          matlab.ui.control.Spinner
        UnitCellDropDownLabel          matlab.ui.control.Label
        LoadLatticeButton              matlab.ui.control.Button
        SaveLatticeButton              matlab.ui.control.Button
        PlotSoundAbsorptionButton      matlab.ui.control.Button
        SavePlotButton                 matlab.ui.control.Button
        ResetButton                    matlab.ui.control.Button
        Image                          matlab.ui.control.Image
        UIAxes                         matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        LatticeStructure % Lattice Object (Indexed linked list)
        Frequency % Frequency Range
        SAC % Calculated SACs
        UnitCellLibrary % Library of CellArchitecture Objects
        CellArchList % List of Cell Architectures
        CellSize % Range of Cell Sizes
        RD % Range of Relative Densities
        CrossSectionList % List of Cross-sections
        Thickness % Total thickness of sample
        SampleLength % Sample Length (square cross-section)
        SampleDiameter % Sample Diameter (circular cross-section)
        SampleLatticeDesigns % Library of example Lattice Objects
        CurrentLayer % Current Lattice Layer to change
        CurrentLayerNum % Current Lattice Layer to change
    end
    
    methods (Access = private)
        
        function setDefaults(app)
            % Set properties
            app.CrossSectionList = ["Circular";"Square"];
            app.CrossSectionDropDown.Items = app.CrossSectionList;
            app.CrossSectionDropDown.Value = app.CrossSectionList(1);

            app.LengthDiametermmSlider.Limits = [10,50];
            app.LengthDiametermmSlider.MajorTicks = 10:10:50;
            app.LengthDiametermmSlider.MinorTicks = 10:2:50;
            app.LengthDiametermmSlider.Value = mean(app.LengthDiametermmSlider.Limits);
            app.SampleLength = app.LengthDiametermmSlider.Value;
            app.SampleDiameter = app.LengthDiametermmSlider.Value;

            app.NumberofDistinctLayersSpinner.Value = 1;

            app.FrequencySpinner.Value = 1000;
            app.FrequencySpinner_2.Value = 6300;
            app.Frequency = app.FrequencySpinner.Value:10:app.FrequencySpinner_2.Value;
            app.SAC = zeros(length(app.Frequency));

            app.UnitCellDropDown.Items = app.CellArchList;
            app.UnitCellDropDown.Value = app.UnitCellDropDown.Items(1);

            app.CellSize = 4:0.1:8;
            app.CellSizemmSlider.Limits = [app.CellSize(1),app.CellSize(end)];
            app.CellSizemmSlider.MajorTicks = 4:1:8;
            app.CellSizemmSlider.MinorTicks = 4:0.2:8;
            app.CellSizemmSlider.Value = mean(app.CellSizemmSlider.Limits);
            
            app.RD = 0.1:0.01:0.4;
            app.RelativeDensitySlider.Limits = [app.RD(1),app.RD(end)];
            app.RelativeDensitySlider.MajorTicks = 0.1:0.1:0.4;
            app.RelativeDensitySlider.MinorTicks = 0.1:0.02:0.4;
            app.RelativeDensitySlider.Value = 0.3;

            app.NumberofLayersSpinner.Value = 1;
            app.ThicknessmmEditField.Value = ...
                app.NumberofLayersSpinner.Value * app.CellSizemmSlider.Value; % Does not accept user input
            app.Thickness = app.ThicknessmmEditField.Value;
            app.LayerNumberDropDown.Items = string(1:app.NumberofLayersSpinner.Value);

            % Initialise lattice layer.
            app.CurrentLayerNum = 1;
            app.defaultLayer();
            app.createLayer(); % Error in setting up array.
            
            % Initialise lattice structure.
            app.LatticeStructure = Lattice(app.CrossSectionDropDown.Value,app.Frequency);
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);

            % Clear plot axes
            cla(app.UIAxes);
        end

        % Default layer properties
        function defaultLayer(app)
            app.UnitCellDropDown.Value = app.UnitCellDropDown.Items(1);
            app.CellSizemmSlider.Value = mean(app.CellSizemmSlider.Limits);
            app.RelativeDensitySlider.Value = 0.3;
            app.NumberofLayersSpinner.Value = 1;
        end

        % Create lattice layer.
        function createLayer(app)
            app.CurrentLayer = LatticeLayer(1,app.UnitCellDropDown.Value, ...
                app.CellSizemmSlider.Value,...
                app.RelativeDensitySlider.Value, ...
                app.CrossSectionDropDown.Value,...
                app.SampleDiameter,...
                app.SampleDiameter,...
                app.NumberofLayersSpinner.Value*app.CellSizemmSlider.Value);
        end

        % Update thickness of sample.
        function updateThickness(app)
            app.Thickness = 0;
            layer = app.LatticeStructure.Head;
		    while ~isempty(layer)
	            app.Thickness = app.Thickness + layer.t_layer;
				layer = layer.Next;
            end
            app.ThicknessmmEditField.Value = app.Thickness;
        end

        % Show lattice layer parameters on app.
        function showLayer(app,layer)
            if nargin == 2
                app.UnitCellDropDown.Value = layer.name;
                app.CellSizemmSlider.Value = layer.cell_length;
                app.RelativeDensitySlider.Value = layer.rel_density;
                app.NumberofLayersSpinner.Value = layer.N_z;
            else
                app.defaultLayer();
            end
        end

        function plotSAC(app)
            color = [0 0.8 0; 0.8 0 0; 0 0 0.8; 0.8 0.6 0];
            line_style = ["--" ":" "-" "-."];
            marker = ['o','+','x','s'];
            
            plot(app.UIAxes,app.Frequency,app.SAC,'DisplayName','Lattice SAC', ...
				'Color',[0 0 0.8],'LineStyle',"-",'LineWidth',2);
            
	        app.UIAxes.XLim = [app.FrequencySpinner.Value app.FrequencySpinner_2.Value];
	        app.UIAxes.YLim = [0 1];
	        app.UIAxes.YTick = 0:0.2:1.0;
	        legend(app.UIAxes,'Location','northeast','NumColumns',1);
	        legend(app.UIAxes,'FontSize',16);
	        legend(app.UIAxes,'boxoff');
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %#function network
            load('Unit Cell Architecture.mat');
            app.UnitCellLibrary = cell_lib;
            app.CellArchList = unit_cell; % Include in Unit Cell Arch
            
            % load('Sample Lattice Designs.mat');
            app.setDefaults();
        end

        % Value changed function: CrossSectionDropDown
        function CrossSectionDropDownValueChanged(app, event)
            NewCrossSection = app.CrossSectionDropDown.Value;
            % Change the cross-section for LatticeStructure and all the
            % Lattice Layers
            app.LatticeStructure.cross_section = NewCrossSection;
            layer = app.LatticeStructure.Head;
			while ~isempty(layer)
	            layer.cross_section = NewCrossSection;
				layer = layer.Next;
            end
            
            % For now, changing the cross section of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: LengthDiametermmSlider
        function LengthDiametermmSliderValueChanged(app, event)
            value = app.LengthDiametermmSlider.Value;
            % Change the length and widths for LatticeStructure and all the
            % Lattice Layers.
            app.LatticeStructure.l_sample = value;
            app.LatticeStructure.w_sample = value;
            layer = app.LatticeStructure.Head;
			while ~isempty(layer)
	            layer.l_layer = value;
                layer.w_layer = value;
				layer = layer.Next;
            end

            % Update SampleLength and SampleDiamater
            app.SampleLength = value;
            app.SampleDiameter = value;

            % For now, changing the length/diameter of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: NumberofDistinctLayersSpinner
        function NumberofDistinctLayersSpinnerValueChanged(app, event)
            value = app.NumberofDistinctLayersSpinner.Value;
            app.LayerNumberDropDown.Items = string(1:value);
            
            % Add or remove Lattice Layers from the LatticeStructure.
            if app.LatticeStructure.num_layers < value
                % Add layers
                while app.LatticeStructure.num_layers < value
                    app.CurrentLayerNum = app.LatticeStructure.num_layers + 1;
                    app.LayerNumberDropDown.Value = app.LayerNumberDropDown.Items(app.CurrentLayerNum);
                    app.showLayer();
                    app.createLayer();
                    app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);
                end
            else
                % Remove layers
                while app.LatticeStructure.num_layers > value
                    app.LatticeStructure.removeLayer(app.LatticeStructure.num_layers);
                end
                app.CurrentLayerNum = app.LatticeStructure.num_layers;
                app.CurrentLayer = app.LatticeStructure.Tail;
                app.LayerNumberDropDown.Value = app.LayerNumberDropDown.Items(app.CurrentLayerNum);
                app.showLayer(app.CurrentLayer);
            end
            % CurrentLayer is set to be the last layer of LatticeStructure.
            app.updateThickness();
        end

        % Value changing function: FrequencySpinner
        function FrequencySpinnerValueChanging(app, event)
            changingValue = event.Value;
            if app.FrequencySpinner_2.Value < changingValue + 100
                app.FrequencySpinner_2.Value = min([changingValue + 100,app.FrequencySpinner_2.Limits(2)]);
            end
            app.Frequency = app.FrequencySpinner.Value:10:app.FrequencySpinner_2.Value;
            app.LatticeStructure.frequency = app.Frequency;
            app.SAC = zeros(length(app.Frequency));
        end

        % Value changing function: FrequencySpinner_2
        function FrequencySpinner_2ValueChanging(app, event)
            changingValue = event.Value;
            if app.FrequencySpinner.Value > changingValue - 100
                app.FrequencySpinner.Value = max([changingValue - 100,app.FrequencySpinner.Limits(1)]);
            end
            app.Frequency = app.FrequencySpinner.Value:10:app.FrequencySpinner_2.Value;
            app.LatticeStructure.frequency = app.Frequency;
            app.SAC = zeros(length(app.Frequency));
        end

        % Value changed function: LayerNumberDropDown
        function LayerNumberDropDownValueChanged(app, event)
            value = app.LayerNumberDropDown.Value;
            app.CurrentLayerNum = str2double(value);
            app.CurrentLayer = app.LatticeStructure.find(app.CurrentLayerNum);
            app.showLayer(app.CurrentLayer);
        end

        % Value changed function: UnitCellDropDown
        function UnitCellDropDownValueChanged(app, event)
            app.LatticeStructure.removeLayer(app.CurrentLayerNum);
            app.createLayer(); % Replaces CurrentLayer with the new one.
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);
        end

        % Value changed function: CellSizemmSlider
        function CellSizemmSliderValueChanged(app, event)
            app.LatticeStructure.removeLayer(app.CurrentLayerNum);
            app.createLayer(); % Replaces CurrentLayer with the new one.
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);
            app.updateThickness(); % Update Thickness
        end

        % Value changed function: RelativeDensitySlider
        function RelativeDensitySliderValueChanged(app, event)
            app.LatticeStructure.removeLayer(app.CurrentLayerNum);
            app.createLayer(); % Replaces CurrentLayer with the new one.
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);
        end

        % Value changed function: NumberofLayersSpinner
        function NumberofLayersSpinnerValueChanged(app, event)
            value = app.NumberofLayersSpinner.Value;
            app.CurrentLayer.N_z = value;
            app.CurrentLayer.t_layer = app.CurrentLayer.N_z * app.CurrentLayer.cell_length;
            app.updateThickness(); % Update Thickness
        end

        % Button pushed function: LoadLatticeButton
        function LoadLatticeButtonPushed(app, event)
            fig = uifigure('Position',[150 150 310 165]);
            uialert(fig,'This feature has not be implemented yet!','Invalid Action');
        end

        % Button pushed function: SaveLatticeButton
        function SaveLatticeButtonPushed(app, event)
            fig = uifigure('Position',[150 150 310 165]);
            uialert(fig,'This feature has not be implemented yet!','Invalid Action');
        end

        % Button pushed function: PlotSoundAbsorptionButton
        function PlotSoundAbsorptionButtonPushed(app, event)
            app.LatticeStructure.calcTMM();
            app.LatticeStructure.calcAlpha();
            app.SAC = app.LatticeStructure.alpha;
            app.plotSAC();
        end

        % Button pushed function: SavePlotButton
        function SavePlotButtonPushed(app, event)
            exportgraphics(app.UIFigure,'Lattice Sound Absorption.tif',"Resolution",500);
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            app.setDefaults();
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 765 460];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Resize = 'off';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Lattice Sound Absorption')
            xlabel(app.UIAxes, 'Frequency (Hz)')
            ylabel(app.UIAxes, 'Sound Absorption Coefficient (\alpha)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XLim = [1000 6300];
            app.UIAxes.FontSize = 20;
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [1 50 450 410];

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [675 1 90 45];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'NUS Zhai Group.png');

            % Create ResetButton
            app.ResetButton = uibutton(app.UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.FontSize = 16;
            app.ResetButton.Position = [570 10 60 28];
            app.ResetButton.Text = 'Reset';

            % Create SavePlotButton
            app.SavePlotButton = uibutton(app.UIFigure, 'push');
            app.SavePlotButton.ButtonPushedFcn = createCallbackFcn(app, @SavePlotButtonPushed, true);
            app.SavePlotButton.FontSize = 16;
            app.SavePlotButton.Position = [450 10 100 28];
            app.SavePlotButton.Text = 'Save Plot';

            % Create PlotSoundAbsorptionButton
            app.PlotSoundAbsorptionButton = uibutton(app.UIFigure, 'push');
            app.PlotSoundAbsorptionButton.ButtonPushedFcn = createCallbackFcn(app, @PlotSoundAbsorptionButtonPushed, true);
            app.PlotSoundAbsorptionButton.FontSize = 16;
            app.PlotSoundAbsorptionButton.Position = [260 10 170 28];
            app.PlotSoundAbsorptionButton.Text = 'Plot Sound Absorption';

            % Create SaveLatticeButton
            app.SaveLatticeButton = uibutton(app.UIFigure, 'push');
            app.SaveLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLatticeButtonPushed, true);
            app.SaveLatticeButton.FontSize = 16;
            app.SaveLatticeButton.Position = [140 10 100 28];
            app.SaveLatticeButton.Text = 'Save Lattice';

            % Create LoadLatticeButton
            app.LoadLatticeButton = uibutton(app.UIFigure, 'push');
            app.LoadLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @LoadLatticeButtonPushed, true);
            app.LoadLatticeButton.FontSize = 16;
            app.LoadLatticeButton.Position = [20 10 100 28];
            app.LoadLatticeButton.Text = 'Load Lattice';

            % Create LayerPanel
            app.LayerPanel = uipanel(app.UIFigure);
            app.LayerPanel.Title = 'Layer';
            app.LayerPanel.FontWeight = 'bold';
            app.LayerPanel.FontSize = 20;
            app.LayerPanel.Position = [455 50 310 200];

            % Create UnitCellDropDownLabel
            app.UnitCellDropDownLabel = uilabel(app.LayerPanel);
            app.UnitCellDropDownLabel.FontSize = 16;
            app.UnitCellDropDownLabel.Position = [4 145 66 22];
            app.UnitCellDropDownLabel.Text = 'Unit Cell';

            % Create NumberofLayersSpinner
            app.NumberofLayersSpinner = uispinner(app.LayerPanel);
            app.NumberofLayersSpinner.Limits = [1 Inf];
            app.NumberofLayersSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofLayersSpinnerValueChanged, true);
            app.NumberofLayersSpinner.HorizontalAlignment = 'center';
            app.NumberofLayersSpinner.FontSize = 16;
            app.NumberofLayersSpinner.Position = [150 6 155 22];
            app.NumberofLayersSpinner.Value = 1;

            % Create RelativeDensitySlider
            app.RelativeDensitySlider = uislider(app.LayerPanel);
            app.RelativeDensitySlider.Limits = [0.1 0.4];
            app.RelativeDensitySlider.MajorTicks = [0.1 0.2 0.3 0.4];
            app.RelativeDensitySlider.ValueChangedFcn = createCallbackFcn(app, @RelativeDensitySliderValueChanged, true);
            app.RelativeDensitySlider.FontSize = 16;
            app.RelativeDensitySlider.Position = [146 70 149 3];
            app.RelativeDensitySlider.Value = 0.3;

            % Create CellSizemmSliderLabel
            app.CellSizemmSliderLabel = uilabel(app.LayerPanel);
            app.CellSizemmSliderLabel.VerticalAlignment = 'top';
            app.CellSizemmSliderLabel.FontSize = 16;
            app.CellSizemmSliderLabel.Position = [4 116 110 22];
            app.CellSizemmSliderLabel.Text = 'Cell Size (mm)';

            % Create CellSizemmSlider
            app.CellSizemmSlider = uislider(app.LayerPanel);
            app.CellSizemmSlider.Limits = [4 8];
            app.CellSizemmSlider.MajorTicks = [4 5 6 7 8];
            app.CellSizemmSlider.ValueChangedFcn = createCallbackFcn(app, @CellSizemmSliderValueChanged, true);
            app.CellSizemmSlider.FontSize = 16;
            app.CellSizemmSlider.Position = [134 125 166 3];
            app.CellSizemmSlider.Value = 6;

            % Create RelativeDensitySliderLabel
            app.RelativeDensitySliderLabel = uilabel(app.LayerPanel);
            app.RelativeDensitySliderLabel.FontSize = 16;
            app.RelativeDensitySliderLabel.Position = [4 61 121 22];
            app.RelativeDensitySliderLabel.Text = 'Relative Density';

            % Create UnitCellDropDown
            app.UnitCellDropDown = uidropdown(app.LayerPanel);
            app.UnitCellDropDown.Items = {'SC', 'BCC', 'FCC'};
            app.UnitCellDropDown.ValueChangedFcn = createCallbackFcn(app, @UnitCellDropDownValueChanged, true);
            app.UnitCellDropDown.FontSize = 16;
            app.UnitCellDropDown.Position = [82 145 224 22];
            app.UnitCellDropDown.Value = 'SC';

            % Create LayerNumberDropDownLabel
            app.LayerNumberDropDownLabel = uilabel(app.LayerPanel);
            app.LayerNumberDropDownLabel.HorizontalAlignment = 'right';
            app.LayerNumberDropDownLabel.FontSize = 20;
            app.LayerNumberDropDownLabel.FontWeight = 'bold';
            app.LayerNumberDropDownLabel.Position = [-4 172 143 27];
            app.LayerNumberDropDownLabel.Text = 'Layer Number';

            % Create LayerNumberDropDown
            app.LayerNumberDropDown = uidropdown(app.LayerPanel);
            app.LayerNumberDropDown.Items = {};
            app.LayerNumberDropDown.ValueChangedFcn = createCallbackFcn(app, @LayerNumberDropDownValueChanged, true);
            app.LayerNumberDropDown.FontSize = 20;
            app.LayerNumberDropDown.Position = [154 172 152 26];
            app.LayerNumberDropDown.Value = {};

            % Create NumberofLayersSpinnerLabel
            app.NumberofLayersSpinnerLabel = uilabel(app.LayerPanel);
            app.NumberofLayersSpinnerLabel.FontSize = 16;
            app.NumberofLayersSpinnerLabel.Position = [4 6 132 22];
            app.NumberofLayersSpinnerLabel.Text = 'Number of Layers';

            % Create LatticePropertiesPanel
            app.LatticePropertiesPanel = uipanel(app.UIFigure);
            app.LatticePropertiesPanel.TitlePosition = 'centertop';
            app.LatticePropertiesPanel.Title = 'Lattice Properties';
            app.LatticePropertiesPanel.FontWeight = 'bold';
            app.LatticePropertiesPanel.FontSize = 20;
            app.LatticePropertiesPanel.Position = [455 260 310 200];

            % Create CrossSectionDropDownLabel
            app.CrossSectionDropDownLabel = uilabel(app.LatticePropertiesPanel);
            app.CrossSectionDropDownLabel.FontSize = 16;
            app.CrossSectionDropDownLabel.Position = [4 145 105 22];
            app.CrossSectionDropDownLabel.Text = 'Cross Section';

            % Create LengthDiametermmSliderLabel
            app.LengthDiametermmSliderLabel = uilabel(app.LatticePropertiesPanel);
            app.LengthDiametermmSliderLabel.WordWrap = 'on';
            app.LengthDiametermmSliderLabel.FontSize = 16;
            app.LengthDiametermmSliderLabel.Position = [4 90 119 48];
            app.LengthDiametermmSliderLabel.Text = 'Length/Diameter (mm)';

            % Create NumberofDistinctLayersSpinnerLabel
            app.NumberofDistinctLayersSpinnerLabel = uilabel(app.LatticePropertiesPanel);
            app.NumberofDistinctLayersSpinnerLabel.FontSize = 16;
            app.NumberofDistinctLayersSpinnerLabel.Position = [4 61 191 22];
            app.NumberofDistinctLayersSpinnerLabel.Text = 'Number of Distinct Layers';

            % Create ThicknessmmEditFieldLabel
            app.ThicknessmmEditFieldLabel = uilabel(app.LatticePropertiesPanel);
            app.ThicknessmmEditFieldLabel.FontSize = 16;
            app.ThicknessmmEditFieldLabel.Position = [4 32 119 22];
            app.ThicknessmmEditFieldLabel.Text = 'Thickness (mm)';

            % Create FrequencySpinner_2
            app.FrequencySpinner_2 = uispinner(app.LatticePropertiesPanel);
            app.FrequencySpinner_2.Step = 50;
            app.FrequencySpinner_2.ValueChangingFcn = createCallbackFcn(app, @FrequencySpinner_2ValueChanging, true);
            app.FrequencySpinner_2.Limits = [50 10000];
            app.FrequencySpinner_2.Tag = 'Frequency_end';
            app.FrequencySpinner_2.HorizontalAlignment = 'center';
            app.FrequencySpinner_2.FontSize = 16;
            app.FrequencySpinner_2.Position = [211 3 75 22];
            app.FrequencySpinner_2.Value = 6300;

            % Create FrequencySpinnerLabel_3
            app.FrequencySpinnerLabel_3 = uilabel(app.LatticePropertiesPanel);
            app.FrequencySpinnerLabel_3.FontSize = 16;
            app.FrequencySpinnerLabel_3.Position = [285 3 25 22];
            app.FrequencySpinnerLabel_3.Text = 'Hz';

            % Create FrequencySpinnerLabel_2
            app.FrequencySpinnerLabel_2 = uilabel(app.LatticePropertiesPanel);
            app.FrequencySpinnerLabel_2.FontSize = 16;
            app.FrequencySpinnerLabel_2.Position = [168 3 43 22];
            app.FrequencySpinnerLabel_2.Text = 'Hz to';

            % Create FrequencySpinnerLabel
            app.FrequencySpinnerLabel = uilabel(app.LatticePropertiesPanel);
            app.FrequencySpinnerLabel.FontSize = 16;
            app.FrequencySpinnerLabel.Position = [4 3 81 22];
            app.FrequencySpinnerLabel.Text = 'Frequency';

            % Create FrequencySpinner
            app.FrequencySpinner = uispinner(app.LatticePropertiesPanel);
            app.FrequencySpinner.Step = 50;
            app.FrequencySpinner.ValueChangingFcn = createCallbackFcn(app, @FrequencySpinnerValueChanging, true);
            app.FrequencySpinner.Limits = [50 10000];
            app.FrequencySpinner.HorizontalAlignment = 'center';
            app.FrequencySpinner.FontSize = 16;
            app.FrequencySpinner.Position = [93 3 75 22];
            app.FrequencySpinner.Value = 1000;

            % Create ThicknessmmEditField
            app.ThicknessmmEditField = uieditfield(app.LatticePropertiesPanel, 'numeric');
            app.ThicknessmmEditField.FontSize = 16;
            app.ThicknessmmEditField.Position = [138 32 167 22];
            app.ThicknessmmEditField.Value = 24;

            % Create NumberofDistinctLayersSpinner
            app.NumberofDistinctLayersSpinner = uispinner(app.LatticePropertiesPanel);
            app.NumberofDistinctLayersSpinner.Limits = [1 6];
            app.NumberofDistinctLayersSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofDistinctLayersSpinnerValueChanged, true);
            app.NumberofDistinctLayersSpinner.HorizontalAlignment = 'center';
            app.NumberofDistinctLayersSpinner.FontSize = 16;
            app.NumberofDistinctLayersSpinner.Position = [204 61 102 22];
            app.NumberofDistinctLayersSpinner.Value = 1;

            % Create LengthDiametermmSlider
            app.LengthDiametermmSlider = uislider(app.LatticePropertiesPanel);
            app.LengthDiametermmSlider.Limits = [10 50];
            app.LengthDiametermmSlider.MajorTicks = [10 20 30 40 50];
            app.LengthDiametermmSlider.ValueChangedFcn = createCallbackFcn(app, @LengthDiametermmSliderValueChanged, true);
            app.LengthDiametermmSlider.FontSize = 16;
            app.LengthDiametermmSlider.Position = [141 126 155 3];
            app.LengthDiametermmSlider.Value = 30;

            % Create CrossSectionDropDown
            app.CrossSectionDropDown = uidropdown(app.LatticePropertiesPanel);
            app.CrossSectionDropDown.Items = {'Circular', 'Square'};
            app.CrossSectionDropDown.ValueChangedFcn = createCallbackFcn(app, @CrossSectionDropDownValueChanged, true);
            app.CrossSectionDropDown.FontSize = 16;
            app.CrossSectionDropDown.Position = [123 145 182 22];
            app.CrossSectionDropDown.Value = 'Circular';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LatticeSoundAbsorption_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

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
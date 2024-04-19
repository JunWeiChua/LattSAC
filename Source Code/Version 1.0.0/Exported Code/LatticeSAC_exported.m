classdef LatticeSAC_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        LatticePropertiesPanel         matlab.ui.container.Panel
        CrossSectionDropDown           matlab.ui.control.DropDown
        LengthDiametermmSliderLabel    matlab.ui.control.Label
        LengthDiametermmSlider         matlab.ui.control.Slider
        LengthDiametermmSliderNumeric  matlab.ui.control.NumericEditField
        NumberofLayersSpinner          matlab.ui.control.Spinner
        ThicknessmmEditField           matlab.ui.control.NumericEditField
        FreqLabel_1                    matlab.ui.control.Label
        FreqLabel_2                    matlab.ui.control.Label
        FreqLabel_3                    matlab.ui.control.Label
        FreqLowerBoundSpinner          matlab.ui.control.Spinner
        FreqUpperBoundSpinner          matlab.ui.control.Spinner
        LoadLatticeButton              matlab.ui.control.Button
        SaveLatticeButton              matlab.ui.control.Button
        ReverseButton                  matlab.ui.control.Button
        ThicknessmmEditFieldLabel      matlab.ui.control.Label
        NumberofLayersSpinnerLabel     matlab.ui.control.Label
        CrossSectionDropDownLabel      matlab.ui.control.Label
        LatticeLayerPropertiesPanel    matlab.ui.container.Panel
        NumberofPartsSpinnerLabel      matlab.ui.control.Label
        LayerNumberDropDown            matlab.ui.control.DropDown
        NumberofPartsSpinner           matlab.ui.control.Spinner
        UITable                        matlab.ui.control.Table
        DoubleClickLabel               matlab.ui.control.Label
        LayerNumberDropDownLabel       matlab.ui.control.Label
        LatticeSACPlotandDataPanel     matlab.ui.container.Panel
        PlotSoundAbsorptionButton      matlab.ui.control.Button
        HzLabel_4                      matlab.ui.control.Label
        HzLabel_3                      matlab.ui.control.Label
        HzLabel_2                      matlab.ui.control.Label
        HzLabel_1                      matlab.ui.control.Label
        NRCEditFieldLabel              matlab.ui.control.Label
        StdDevSACEditFieldLabel        matlab.ui.control.Label
        MeanSACEditField               matlab.ui.control.NumericEditField
        StdDevSACEditField             matlab.ui.control.NumericEditField
        NRCEditField                   matlab.ui.control.NumericEditField
        FreqBand_1                     matlab.ui.control.NumericEditField
        FreqBand_2                     matlab.ui.control.NumericEditField
        FreqBand_3                     matlab.ui.control.NumericEditField
        FreqBand_4                     matlab.ui.control.NumericEditField
        MeanSACEditFieldLabel          matlab.ui.control.Label
        UIAxes                         matlab.ui.control.UIAxes
        ExportDataPanel                matlab.ui.container.Panel
        ExportLatticeDesignButton      matlab.ui.control.Button
        SaveSACPlotandDataButton       matlab.ui.control.Button
        ApplicationControlPanel        matlab.ui.container.Panel
        RefreshButton                  matlab.ui.control.Button
        ResetButton                    matlab.ui.control.Button
        CloseButton                    matlab.ui.control.Button
        AppTitle                       matlab.ui.control.Label
        ToUseLabel                     matlab.ui.control.Label
        ZhaiGroupLogo                  matlab.ui.control.Image
        NUSLogo                        matlab.ui.control.Image
        DesignedBy                     matlab.ui.control.Label
        VersionNum                     matlab.ui.control.Label
    end

    
    properties (Access = private)
        % Libraries
        CellArchLibrary     % Library of CellArchitecture Objects
        CellArchList        % List of Cell Architectures
        LatticeLibrary      % Library of example Lattice Objects
        LatticeLibraryLabels % Library of example Lattice Objects
        
        % Lists and Ranges
        CrossSectionList    % List of Cross-sections
        FrequencyFull       % Full Frequency Range
        CellType            % Range of Cell Types
        CellSize            % Range of Cell Sizes
        RelativeDensity     % Range of Relative Densities

        % Objects
        LatticeStructure    % Lattice Object (Indexed linked list)
        LattLayerPartTable  % Lattice Layer - Table of Parts
        CurrentLayerNum     % Current LattLayer to change
        CurrentLayerNode    % Current LattLayer to change (LLNode)
        CurrentLayer        % Current LattLayer to change (LattLayer)
        CurrentPartNum      % Current LattLayerPart to change
        CurrentPartNode     % Current LattLayerPart to change (LLNode)
        CurrentPart         % Current LattLayerPart to change (LattLayerPart)

        % Properties
        CrossSection        % Sample Cross Section
        SampleLength        % Sample Length (square cross-section)
        SampleDiameter      % Sample Diameter (circular cross-section)
        NumLayers           % Number of Layers for Sample
        Thickness           % Total thickness of sample
        Frequency           % Frequency Range
        NumParts            % Number of parts for CurrentLayer.
        DefaultUC           % Default Unit Cell
        DefaultCS           % Default Cell Size
        DefaultRD           % Default Relative Density
        DefaultNumLayer     % Default Number of Layers
        
        % Side Apps
        LattLayerPartProp   % LattLayerPartProperties App
        LoadLattApp         % Load Lattice App
        SaveLattApp         % Save Lattice App
        ExportLattApp       % Export Lattice App
        SaveSACApp          % Save SAC Plot and Data App
    end
    
    methods (Access = private)
        
        function setDefaults(app)
            % Set Lists and Ranges
            app.CrossSectionList = ["Circular";"Square"];
            app.CellType = categorical({'Strut','Plate','TPMS','Hollow Truss'});
            app.CellSize = 4:0.1:8;
            app.RelativeDensity = 0.1:0.01:0.4;
            app.FrequencyFull = 100:10:6300;

            % Lattice Properties
            app.CrossSectionDropDown.Items = app.CrossSectionList;
            app.CrossSectionDropDown.Value = app.CrossSectionList(1);
            app.CrossSection = app.CrossSectionDropDown.Value;
            
            app.LengthDiametermmSlider.Limits = [10,50];
            app.LengthDiametermmSlider.MajorTicks = 10:10:50;
            app.LengthDiametermmSlider.MinorTicks = 10:2:50;
            app.LengthDiametermmSlider.Value = mean(app.LengthDiametermmSlider.Limits);
            app.LengthDiametermmSliderNumeric.Value = app.LengthDiametermmSlider.Value;
            app.SampleLength = app.LengthDiametermmSlider.Value;
            app.SampleDiameter = app.LengthDiametermmSlider.Value;
            
            app.NumberofLayersSpinner.Value = 1;
            app.NumberofPartsSpinner.Value = 1;
            
            app.FreqLowerBoundSpinner.Value = 1000;
            app.FreqUpperBoundSpinner.Value = 6300;

            app.defaultPart();
            
            % Initialise first LattLayer.
            app.CurrentLayerNum = 1;
            app.LayerNumberDropDown.Value = app.LayerNumberDropDown.Items(1);
            app.createLayer();
            
            % Initialise LatticeStructure.
            app.LatticeStructure = Lattice(app.CrossSection,app.FrequencyFull);
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,1);

            % Clear plot axes
            cla(app.UIAxes);
            app.MeanSACEditField.Value = 0;
	        app.StdDevSACEditField.Value = 0;
	        app.NRCEditField.Value = 0;
	        app.FreqBand_1.Value = 0;
	        app.FreqBand_2.Value = 0;
            app.FreqBand_3.Value = 0;
	        app.FreqBand_4.Value = 0;
        end

        % Default LattLayerPart properties
        function defaultPart(app)
            app.DefaultUC = app.CellArchList(1);
            app.DefaultCS = mean([app.CellSize(1),app.CellSize(end)]);
            app.DefaultRD = 0.3;
            app.DefaultNumLayer = 1;
        end

        % Create new LattLayerPart.
        function createPart(app)
            app.CurrentPart = LattLayerStrut(app.DefaultUC, ...
                app.DefaultCS, ...
                app.DefaultRD, ...
                app.CrossSection,...
                app.SampleDiameter,...
                app.SampleDiameter,...
                app.DefaultNumLayer);
        end

        % Create new LattLayer.
        function createLayer(app)
            % Initialise first LattLayerPart.
            app.CurrentPartNum = 1;
            app.defaultPart();
            app.createPart();
            
            % Initialise new LattLayer.
            app.CurrentLayer = LattLayer(app.CrossSection,app.FrequencyFull);
            app.CurrentLayer.insertPart(app.CurrentPart,1);
            app.CurrentPartNode = app.CurrentLayer.Head;
        end

        % Plot sound absorption coefficient on axes.
        function plotSAC(app)
            color = [0 0.8 0; 0.8 0 0; 0 0 0.8; 0.8 0.6 0];
            line_style = ["--" ":" "-" "-."];
            marker = ['o','+','x','s'];
            
            plot(app.UIAxes,app.FrequencyFull,app.LatticeStructure.SAC, ...
                'DisplayName','Lattice SAC', ...
				'Color',[0 0 0.8],'LineStyle',"-",'LineWidth',2);
            
	        app.UIAxes.XLim = [app.Frequency(1) app.Frequency(end)];
	        app.UIAxes.YLim = [0 1];
	        app.UIAxes.YTick = 0:0.2:1.0;
	        legend(app.UIAxes,'Location','northeast','NumColumns',1);
	        legend(app.UIAxes,'FontSize',16);
	        legend(app.UIAxes,'boxoff');

            calcSACstats(app);
        end

        % Show SAC stats in UI.
        function calcSACstats(app)
            freq = app.FrequencyFull;
	        alpha = app.LatticeStructure.SAC;
	        
	        % Determine cutoffs
	        cutoff = zeros(5,1);
            freq_cutoff = [500;1000;2000;4000;6300];
	        for i = 1:length(freq)
		        for j = 1:length(freq_cutoff)
                    if freq(i) < freq_cutoff(j)
			            cutoff(j) = cutoff(j) + 1;
		            end
                end
	        end
	        
	        app.MeanSACEditField.Value = mean(alpha);
	        app.StdDevSACEditField.Value = sqrt(var(alpha));
            NRCfreq = [250; 500; 1000; 2000];
	        app.NRCEditField.Value = ...
                mean(alpha(ismember(freq,NRCfreq)));
	        app.FreqBand_1.Value = mean(alpha(cutoff(1)+1:cutoff(2)));
	        app.FreqBand_2.Value = mean(alpha(cutoff(2)+1:cutoff(3)));
            app.FreqBand_3.Value = mean(alpha(cutoff(3)+1:cutoff(4)));
	        app.FreqBand_4.Value = mean(alpha(cutoff(4)+1:cutoff(5)));
        end
    end
    
    methods (Access = public)
        
        % Load the current LatticeStructure
        function loadLattice(app,Lattice,partUpdate)
            % CurrentLayer is set to be the first layer of LatticeStructure.
            app.CurrentLayerNum = 1;
            app.CurrentLayerNode = Lattice.Head;
            app.CurrentLayer = app.CurrentLayerNode.Data;

            % CurrentPart is set to be the first part of LattLayer.
            app.CurrentPartNum = 1;
            app.CurrentPartNode = app.CurrentLayer.Head;
            app.CurrentPart = app.CurrentPartNode.Data;

            % Set values of properties on app UI.
            CrossSectionNum = ...
                find(app.CrossSectionList == Lattice.CrossSection);
            app.CrossSectionDropDown.Value = ...
                app.CrossSectionDropDown.Items(CrossSectionNum);
            app.LengthDiametermmSlider.Value = Lattice.l_sample;
            app.LengthDiametermmSliderNumeric.Value = ...
                app.LengthDiametermmSlider.Value;
            app.NumberofLayersSpinner.Value = Lattice.num_layers;
            app.FreqLowerBoundSpinner.Value = 1000;
            app.FreqUpperBoundSpinner.Value = 6300;
            app.NumberofPartsSpinner.Value = app.CurrentLayer.Length;
            app.showTable(app.CurrentLayer);

            % Set the properties within the main app.
            app.CrossSection = app.CrossSectionDropDown.Value;
            app.SampleLength = app.LengthDiametermmSlider.Value;
            app.SampleDiameter = app.LengthDiametermmSlider.Value;
            app.LengthDiametermmSliderNumeric.Value = app.LengthDiametermmSlider.Value;
            app.NumLayers = app.NumberofLayersSpinner.Value;
            app.NumParts = app.NumberofPartsSpinner.Value;
            app.LayerNumberDropDown.Items = string(1:app.NumLayers);
            app.LayerNumberDropDown.Value = ...
                app.LayerNumberDropDown.Items(app.CurrentLayerNum);
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            app.LatticeStructure.updateThickness(partUpdate);
            app.updateThickness();
        end

        function updateThickness(app)
            app.Thickness = app.LatticeStructure.t_sample;
            app.ThicknessmmEditField.Value = app.Thickness;
        end

        % Update part table.
        function showTable(app,layer)
            app.UITable.Data = [];

            % Create new LattLayerPartTable.
            app.LattLayerPartTable = [];
            app.LattLayerPartTable = table('Size',[0 3],...
                'VariableTypes',["categorical","double","double"], ...
                'VariableNames',["Cell Type","Thickness","Surface Ratio"]);
            
            % Add rows for LattLayerPartTable.
            cur = layer.Head;
            while ~isempty(cur)
                cellTypeIdx = find(app.CellType==cur.Data.UnitCell.CellArch.CellType);
                app.LattLayerPartTable(cur.Index,:) = ...
                    {app.CellType(cellTypeIdx), ...
                    cur.Data.t_part,cur.Data.SurfaceRatio};
                cur = cur.Next;
            end
            
            % Show LattLayerPartTable on UI.
            app.UITable.Data = app.LattLayerPartTable;
            app.UITable.RowName = 'numbered';
        end

        % Update Lattice Library and Labels
        function updateLattLib(app,LattLibrary,LattLibraryLabel)
            app.LatticeLibrary = LattLibrary;
            app.LatticeLibraryLabels = LattLibraryLabel;
            LattLib = app.LatticeLibrary;
            LattLabel = app.LatticeLibraryLabels;
            save('Lattice Library.mat','LattLib','LattLabel');
        end

        % Updates Main App after Exiting from LoadLatt App.
        function loadLatt(app,Lattice)
            % Update the LatticeStructure in the main app.
            app.LatticeStructure = Lattice.copyLatt();

            % Update Lattice Properties of main app
            app.loadLattice(app.LatticeStructure,1);
        end

        % Save Lattice into Lattice Library
        function saveLatt(app,Name)
            app.LatticeLibrary.insert(app.LatticeStructure,app.LatticeLibrary.Length+1);
			app.LatticeLibraryLabels.insert(Name,app.LatticeLibraryLabels.Length+1);
            LattLib = app.LatticeLibrary;
            LattLabel = app.LatticeLibraryLabels;
            save('Lattice Library.mat','LattLib','LattLabel');
        end

        % Updates Main App after Exiting from LattPartProp App.
        function updatePart(app,NewPart)
            % Update the LattLayerPart in the main app.
            app.CurrentLayer.remove(app.CurrentPartNum);
            app.CurrentLayer.insert(NewPart,app.CurrentPartNum);
            
            % Update Thickness of main app
            app.LatticeStructure.updateThickness(0);
            app.updateThickness();
            app.showTable(app.CurrentLayer);
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %#function network
            load('Unit Cell Architecture.mat');
            app.CellArchLibrary = cellArchLib;
            app.CellArchList = unit_cell; % Include in Unit Cell Arch
            
            load('Lattice Library.mat');
            app.LatticeLibrary = LattLib;
            app.LatticeLibraryLabels = LattLabel;

            app.setDefaults();
        end

        % Value changed function: CrossSectionDropDown
        function CrossSectionDropDownValueChanged(app, event)
            value = app.CrossSectionDropDown.Value;
            
            app.LatticeStructure.changeParam(value, ...
                app.LatticeStructure.l_sample, ...
                app.LatticeStructure.w_sample);

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,0);

            % For now, changing the cross section of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: LengthDiametermmSlider
        function LengthDiametermmSliderValueChanged(app, event)
            value = app.LengthDiametermmSlider.Value;
            
            app.LatticeStructure.changeParam(app.CrossSection, ...
                value,value);

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,0);
            
            % For now, changing the length/diameter of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: NumberofLayersSpinner
        function NumberofLayersSpinnerValueChanged(app, event)
            value = app.NumberofLayersSpinner.Value;
            
            % Add or remove Lattice Layers from the LatticeStructure.
            if app.NumLayers < value
                % Add layers
                while app.LatticeStructure.num_layers < value
                    app.createLayer();
                    app.LatticeStructure.insertLayer(app.CurrentLayer, ...
                        app.LatticeStructure.num_layers + 1);
                end
            else
                % Remove layers
                while app.LatticeStructure.num_layers > value
                    app.LatticeStructure.removeLayer(app.LatticeStructure.num_layers);
                end
            end

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,0);
        end

        % Value changing function: FreqLowerBoundSpinner
        function FreqLowerBoundSpinnerValueChanging(app, event)
            changingValue = event.Value;
            if app.FreqUpperBoundSpinner.Value < changingValue + 100
                app.FreqUpperBoundSpinner.Value = ...
                    min([changingValue + 100,app.FreqUpperBoundSpinner.Limits(2)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
        end

        % Value changing function: FreqUpperBoundSpinner
        function FreqUpperBoundSpinnerValueChanging(app, event)
            changingValue = event.Value;
            if app.FreqLowerBoundSpinner.Value > changingValue - 100
                app.FreqLowerBoundSpinner.Value = ...
                    max([changingValue - 100,app.FreqLowerBoundSpinner.Limits(1)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
        end

        % Button pushed function: LoadLatticeButton
        function LoadLatticeButtonPushed(app, event)
            app.LoadLattApp = LoadLatt(app,app.LatticeLibrary,app.LatticeLibraryLabels);
        end

        % Button pushed function: SaveLatticeButton
        function SaveLatticeButtonPushed(app, event)
            app.SaveLattApp = SaveLatt(app);
        end

        % Button pushed function: ReverseButton
        function ReverseButtonPushed(app, event)
            app.LatticeStructure.reverseLatt();
            
            % Refresh all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,1);
        end

        % Value changed function: LayerNumberDropDown
        function LayerNumberDropDownValueChanged(app, event)
            value = app.LayerNumberDropDown.Value;
            app.CurrentLayerNum = str2double(value);
            app.CurrentLayerNode = app.LatticeStructure.getNode(app.CurrentLayerNum);
            app.CurrentLayer = app.CurrentLayerNode.Data;
            
            app.NumParts = app.CurrentLayer.Length;
            app.NumberofPartsSpinner.Value = app.NumParts;
            
            app.CurrentPartNum = 1;
            app.CurrentPartNode = app.CurrentLayer.Head;
            app.CurrentPart = app.CurrentPartNode.Data;

            % Update LattLayerPartTable
            app.showTable(app.CurrentLayer);
        end

        % Value changed function: NumberofPartsSpinner
        function NumberofPartsSpinnerValueChanged(app, event)
            value = app.NumberofPartsSpinner.Value;
            
            % Add or remove LattLayerParts from the LattLayer.
            if app.NumParts < value
                % Add parts
                while app.CurrentLayer.Length < value
                    app.createPart();
                    app.CurrentLayer.insertPart(app.CurrentPart, ...
                        1/(app.CurrentLayer.Length+1) );
                end
            else
                % Remove parts
                while app.CurrentLayer.Length > value
                    app.CurrentLayer.removePart(app.CurrentLayer.Length);
                end
            end

            % CurrentPart is set to be the last part of LattLayer.
            app.CurrentPartNum = app.CurrentLayer.Length;
            app.CurrentPartNode = app.CurrentLayer.Tail;
            app.CurrentPart = app.CurrentPartNode.Data;

            % Update LattLayerPartTable
            app.showTable(app.CurrentLayer);
        end

        % Value changing function: NumberofPartsSpinner
        function NumberofPartsSpinnerValueChanging(app, event)
            changingValue = event.Value;
            
            % Add or remove LattLayerParts from the LattLayer.
            if app.NumParts < changingValue
                % Add parts
                while app.CurrentLayer.Length < changingValue
                    app.createPart();
                    app.CurrentLayer.insertPart(app.CurrentPart, ...
                        1/(app.CurrentLayer.Length+1) );
                end
            else
                % Remove parts
                while app.CurrentLayer.Length > changingValue
                    app.CurrentLayer.removePart(app.CurrentLayer.Length);
                end
            end

            % CurrentPart is set to be the last part of LattLayer.
            app.CurrentPartNum = app.CurrentLayer.Length;
            app.CurrentPartNode = app.CurrentLayer.Tail;
            app.CurrentPart = app.CurrentPartNode.Data;

            % Update LattLayerPartTable
            app.showTable(app.CurrentLayer);
        end

        % Double-clicked callback: UITable
        function UITableDoubleClicked(app, event)
            displayRow = event.InteractionInformation.DisplayRow;

            if ~isempty(displayRow)
                app.CurrentPartNum = displayRow;
                app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
                app.CurrentPart = app.CurrentPartNode.Data;

                app.LattLayerPartProp = ...
                    LattPartProp(app,app.CurrentPart,app.CellArchList, ...
                    app.CellSize,app.RelativeDensity);
            end
        end

        % Button pushed function: PlotSoundAbsorptionButton
        function PlotSoundAbsorptionButtonPushed(app, event)
            % Refresh all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,1);

            app.LatticeStructure.calcTMM();
            app.LatticeStructure.calcSAC();
            app.plotSAC();
        end

        % Button pushed function: ExportLatticeDesignButton
        function ExportLatticeDesignButtonPushed(app, event)
            app.ExportLattApp = ExportLatt(app,app.LatticeStructure);
        end

        % Button pushed function: SaveSACPlotandDataButton
        function SaveSACPlotandDataButtonPushed(app, event)
            app.SaveSACApp = SaveSAC(app,app.LatticeStructure);
        end

        % Button pushed function: RefreshButton
        function RefreshButtonPushed(app, event)
            % Refresh all properties on UI and main app.
            app.loadLattice(app.LatticeStructure,1);
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            app.setDefaults();
        end

        % Button pushed function: CloseButton
        function CloseButtonPushed(app, event)
            delete(app.LattLayerPartProp);
            delete(app.LoadLattApp);
            delete(app.SaveLattApp);
            delete(app.ExportLattApp);
            delete(app.SaveSACApp);
            delete(app);
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            delete(app.LattLayerPartProp);
            delete(app.LoadLattApp);
            delete(app.SaveLattApp);
            delete(app.ExportLattApp);
            delete(app.SaveSACApp);
            delete(app);
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
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 1000 750];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create VersionNum
            app.VersionNum = uilabel(app.UIFigure);
            app.VersionNum.HorizontalAlignment = 'right';
            app.VersionNum.VerticalAlignment = 'top';
            app.VersionNum.WordWrap = 'on';
            app.VersionNum.FontSize = 16;
            app.VersionNum.FontAngle = 'italic';
            app.VersionNum.Position = [740 1 260 22];
            app.VersionNum.Text = 'Version 1.0.0. ';

            % Create DesignedBy
            app.DesignedBy = uilabel(app.UIFigure);
            app.DesignedBy.VerticalAlignment = 'top';
            app.DesignedBy.WordWrap = 'on';
            app.DesignedBy.FontSize = 16;
            app.DesignedBy.FontAngle = 'italic';
            app.DesignedBy.Position = [2 1 350 22];
            app.DesignedBy.Text = 'Designed by Chua Jun Wei for NUS Zhai Group.';

            % Create NUSLogo
            app.NUSLogo = uiimage(app.UIFigure);
            app.NUSLogo.Position = [802 651 200 100];
            app.NUSLogo.ImageSource = fullfile(pathToMLAPP, 'NUS Logo.png');

            % Create ZhaiGroupLogo
            app.ZhaiGroupLogo = uiimage(app.UIFigure);
            app.ZhaiGroupLogo.Position = [2 651 220 100];
            app.ZhaiGroupLogo.ImageSource = fullfile(pathToMLAPP, 'NUS Zhai Group Logo.png');

            % Create ToUseLabel
            app.ToUseLabel = uilabel(app.UIFigure);
            app.ToUseLabel.VerticalAlignment = 'top';
            app.ToUseLabel.WordWrap = 'on';
            app.ToUseLabel.FontSize = 16;
            app.ToUseLabel.Position = [220 648 582 50];
            app.ToUseLabel.Text = 'To Use: Simply fill up all the necessary parameters of your desired lattice structure and plot the sound absorption coefficients (SAC).';

            % Create AppTitle
            app.AppTitle = uilabel(app.UIFigure);
            app.AppTitle.HorizontalAlignment = 'center';
            app.AppTitle.FontSize = 26;
            app.AppTitle.FontWeight = 'bold';
            app.AppTitle.Position = [221 701 581 50];
            app.AppTitle.Text = 'Lattice Sound Absorption Design Application';

            % Create ApplicationControlPanel
            app.ApplicationControlPanel = uipanel(app.UIFigure);
            app.ApplicationControlPanel.BorderWidth = 2;
            app.ApplicationControlPanel.TitlePosition = 'centertop';
            app.ApplicationControlPanel.Title = 'Application Control';
            app.ApplicationControlPanel.BackgroundColor = [1 1 1];
            app.ApplicationControlPanel.FontWeight = 'bold';
            app.ApplicationControlPanel.FontSize = 24;
            app.ApplicationControlPanel.Position = [675 25 320 145];

            % Create CloseButton
            app.CloseButton = uibutton(app.ApplicationControlPanel, 'push');
            app.CloseButton.ButtonPushedFcn = createCallbackFcn(app, @CloseButtonPushed, true);
            app.CloseButton.FontSize = 20;
            app.CloseButton.Position = [94 15 130 33];
            app.CloseButton.Text = 'Close';

            % Create ResetButton
            app.ResetButton = uibutton(app.ApplicationControlPanel, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.FontSize = 20;
            app.ResetButton.Position = [170 60 130 33];
            app.ResetButton.Text = 'Reset';

            % Create RefreshButton
            app.RefreshButton = uibutton(app.ApplicationControlPanel, 'push');
            app.RefreshButton.ButtonPushedFcn = createCallbackFcn(app, @RefreshButtonPushed, true);
            app.RefreshButton.FontSize = 20;
            app.RefreshButton.Position = [15 60 130 33];
            app.RefreshButton.Text = 'Refresh';

            % Create ExportDataPanel
            app.ExportDataPanel = uipanel(app.UIFigure);
            app.ExportDataPanel.BorderWidth = 2;
            app.ExportDataPanel.TitlePosition = 'centertop';
            app.ExportDataPanel.Title = '4. Export Data';
            app.ExportDataPanel.BackgroundColor = [1 1 1];
            app.ExportDataPanel.FontWeight = 'bold';
            app.ExportDataPanel.FontSize = 24;
            app.ExportDataPanel.Position = [395 25 275 145];

            % Create SaveSACPlotandDataButton
            app.SaveSACPlotandDataButton = uibutton(app.ExportDataPanel, 'push');
            app.SaveSACPlotandDataButton.ButtonPushedFcn = createCallbackFcn(app, @SaveSACPlotandDataButtonPushed, true);
            app.SaveSACPlotandDataButton.FontSize = 20;
            app.SaveSACPlotandDataButton.Position = [15 15 240 33];
            app.SaveSACPlotandDataButton.Text = 'Save SAC Plot and Data';

            % Create ExportLatticeDesignButton
            app.ExportLatticeDesignButton = uibutton(app.ExportDataPanel, 'push');
            app.ExportLatticeDesignButton.ButtonPushedFcn = createCallbackFcn(app, @ExportLatticeDesignButtonPushed, true);
            app.ExportLatticeDesignButton.FontSize = 20;
            app.ExportLatticeDesignButton.Position = [15 60 240 33];
            app.ExportLatticeDesignButton.Text = 'Export Lattice Design';

            % Create LatticeSACPlotandDataPanel
            app.LatticeSACPlotandDataPanel = uipanel(app.UIFigure);
            app.LatticeSACPlotandDataPanel.BorderWidth = 2;
            app.LatticeSACPlotandDataPanel.TitlePosition = 'centertop';
            app.LatticeSACPlotandDataPanel.Title = '3. Lattice SAC Plot and Data';
            app.LatticeSACPlotandDataPanel.BackgroundColor = [1 1 1];
            app.LatticeSACPlotandDataPanel.FontWeight = 'bold';
            app.LatticeSACPlotandDataPanel.FontSize = 24;
            app.LatticeSACPlotandDataPanel.Position = [395 175 600 470];

            % Create UIAxes
            app.UIAxes = uiaxes(app.LatticeSACPlotandDataPanel);
            title(app.UIAxes, 'Lattice Sound Absorption')
            xlabel(app.UIAxes, 'Frequency (Hz)')
            ylabel(app.UIAxes, 'Sound Absorption Cefficient (\alpha)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.XLim = [1000 6300];
            app.UIAxes.XTick = [1000 2000 3000 4000 5000 6000];
            app.UIAxes.XTickLabel = {'1000'; '2000'; '3000'; '4000'; '5000'; '6000'};
            app.UIAxes.BoxStyle = 'full';
            app.UIAxes.Box = 'on';
            app.UIAxes.FontSize = 20;
            app.UIAxes.Position = [5 5 450 420];

            % Create MeanSACEditFieldLabel
            app.MeanSACEditFieldLabel = uilabel(app.LatticeSACPlotandDataPanel);
            app.MeanSACEditFieldLabel.FontSize = 16;
            app.MeanSACEditFieldLabel.Position = [465 398 120 25];
            app.MeanSACEditFieldLabel.Text = 'Mean SAC';

            % Create FreqBand_4
            app.FreqBand_4 = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.FreqBand_4.Editable = 'off';
            app.FreqBand_4.HorizontalAlignment = 'center';
            app.FreqBand_4.FontSize = 16;
            app.FreqBand_4.Position = [465 73 120 25];

            % Create FreqBand_3
            app.FreqBand_3 = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.FreqBand_3.Editable = 'off';
            app.FreqBand_3.HorizontalAlignment = 'center';
            app.FreqBand_3.FontSize = 16;
            app.FreqBand_3.Position = [465 123 120 25];

            % Create FreqBand_2
            app.FreqBand_2 = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.FreqBand_2.Editable = 'off';
            app.FreqBand_2.HorizontalAlignment = 'center';
            app.FreqBand_2.FontSize = 16;
            app.FreqBand_2.Position = [465 173 120 25];

            % Create FreqBand_1
            app.FreqBand_1 = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.FreqBand_1.Editable = 'off';
            app.FreqBand_1.HorizontalAlignment = 'center';
            app.FreqBand_1.FontSize = 16;
            app.FreqBand_1.Position = [465 223 120 25];

            % Create NRCEditField
            app.NRCEditField = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.NRCEditField.Editable = 'off';
            app.NRCEditField.HorizontalAlignment = 'center';
            app.NRCEditField.FontSize = 16;
            app.NRCEditField.Position = [465 273 120 25];

            % Create StdDevSACEditField
            app.StdDevSACEditField = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.StdDevSACEditField.Editable = 'off';
            app.StdDevSACEditField.HorizontalAlignment = 'center';
            app.StdDevSACEditField.FontSize = 16;
            app.StdDevSACEditField.Position = [465 323 120 25];

            % Create MeanSACEditField
            app.MeanSACEditField = uieditfield(app.LatticeSACPlotandDataPanel, 'numeric');
            app.MeanSACEditField.Editable = 'off';
            app.MeanSACEditField.HorizontalAlignment = 'center';
            app.MeanSACEditField.FontSize = 16;
            app.MeanSACEditField.Position = [465 373 120 25];

            % Create StdDevSACEditFieldLabel
            app.StdDevSACEditFieldLabel = uilabel(app.LatticeSACPlotandDataPanel);
            app.StdDevSACEditFieldLabel.FontSize = 16;
            app.StdDevSACEditFieldLabel.Position = [465 348 120 25];
            app.StdDevSACEditFieldLabel.Text = 'StdDev SAC';

            % Create NRCEditFieldLabel
            app.NRCEditFieldLabel = uilabel(app.LatticeSACPlotandDataPanel);
            app.NRCEditFieldLabel.FontSize = 16;
            app.NRCEditFieldLabel.Position = [464 298 120 25];
            app.NRCEditFieldLabel.Text = 'NRC';

            % Create HzLabel_1
            app.HzLabel_1 = uilabel(app.LatticeSACPlotandDataPanel);
            app.HzLabel_1.FontSize = 16;
            app.HzLabel_1.Position = [464 248 120 25];
            app.HzLabel_1.Text = '  500 - 1000 Hz';

            % Create HzLabel_2
            app.HzLabel_2 = uilabel(app.LatticeSACPlotandDataPanel);
            app.HzLabel_2.FontSize = 16;
            app.HzLabel_2.Position = [464 198 120 25];
            app.HzLabel_2.Text = '1000 - 2000 Hz';

            % Create HzLabel_3
            app.HzLabel_3 = uilabel(app.LatticeSACPlotandDataPanel);
            app.HzLabel_3.FontSize = 16;
            app.HzLabel_3.Position = [464 148 120 25];
            app.HzLabel_3.Text = '2000 - 4000 Hz';

            % Create HzLabel_4
            app.HzLabel_4 = uilabel(app.LatticeSACPlotandDataPanel);
            app.HzLabel_4.FontSize = 16;
            app.HzLabel_4.Position = [464 98 120 25];
            app.HzLabel_4.Text = '4000 - 6300 Hz';

            % Create PlotSoundAbsorptionButton
            app.PlotSoundAbsorptionButton = uibutton(app.LatticeSACPlotandDataPanel, 'push');
            app.PlotSoundAbsorptionButton.ButtonPushedFcn = createCallbackFcn(app, @PlotSoundAbsorptionButtonPushed, true);
            app.PlotSoundAbsorptionButton.FontSize = 20;
            app.PlotSoundAbsorptionButton.Position = [465 10 120 55];
            app.PlotSoundAbsorptionButton.Text = {'Plot Sound'; 'Absorption'};

            % Create LatticeLayerPropertiesPanel
            app.LatticeLayerPropertiesPanel = uipanel(app.UIFigure);
            app.LatticeLayerPropertiesPanel.BorderWidth = 2;
            app.LatticeLayerPropertiesPanel.TitlePosition = 'centertop';
            app.LatticeLayerPropertiesPanel.Title = '2. Lattice Layer Properties';
            app.LatticeLayerPropertiesPanel.BackgroundColor = [1 1 1];
            app.LatticeLayerPropertiesPanel.FontWeight = 'bold';
            app.LatticeLayerPropertiesPanel.FontSize = 24;
            app.LatticeLayerPropertiesPanel.Position = [5 25 385 340];

            % Create LayerNumberDropDownLabel
            app.LayerNumberDropDownLabel = uilabel(app.LatticeLayerPropertiesPanel);
            app.LayerNumberDropDownLabel.FontSize = 16;
            app.LayerNumberDropDownLabel.Position = [10 270 106 22];
            app.LayerNumberDropDownLabel.Text = 'Layer Number';

            % Create DoubleClickLabel
            app.DoubleClickLabel = uilabel(app.LatticeLayerPropertiesPanel);
            app.DoubleClickLabel.WordWrap = 'on';
            app.DoubleClickLabel.FontAngle = 'italic';
            app.DoubleClickLabel.Position = [10 1 360 30];
            app.DoubleClickLabel.Text = '*Notes: Click on the dropdown menu on the first row to change cell type. Double-click on the table row to change part properties.';

            % Create UITable
            app.UITable = uitable(app.LatticeLayerPropertiesPanel);
            app.UITable.ColumnName = {'Type'; 'Thickness'; 'Surface Ratio'};
            app.UITable.ColumnWidth = {60, 'auto', 'auto'};
            app.UITable.RowName = {'''numbered'''};
            app.UITable.ColumnEditable = [true false false];
            app.UITable.DoubleClickedFcn = createCallbackFcn(app, @UITableDoubleClicked, true);
            app.UITable.Multiselect = 'off';
            app.UITable.FontSize = 14;
            app.UITable.Position = [10 35 360 195];

            % Create NumberofPartsSpinner
            app.NumberofPartsSpinner = uispinner(app.LatticeLayerPropertiesPanel);
            app.NumberofPartsSpinner.ValueChangingFcn = createCallbackFcn(app, @NumberofPartsSpinnerValueChanging, true);
            app.NumberofPartsSpinner.Limits = [1 6];
            app.NumberofPartsSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofPartsSpinnerValueChanged, true);
            app.NumberofPartsSpinner.HorizontalAlignment = 'center';
            app.NumberofPartsSpinner.FontSize = 16;
            app.NumberofPartsSpinner.Position = [160 239 210 22];
            app.NumberofPartsSpinner.Value = 1;

            % Create LayerNumberDropDown
            app.LayerNumberDropDown = uidropdown(app.LatticeLayerPropertiesPanel);
            app.LayerNumberDropDown.Items = {'1'};
            app.LayerNumberDropDown.ValueChangedFcn = createCallbackFcn(app, @LayerNumberDropDownValueChanged, true);
            app.LayerNumberDropDown.FontSize = 16;
            app.LayerNumberDropDown.Position = [160 270 210 22];
            app.LayerNumberDropDown.Value = '1';

            % Create NumberofPartsSpinnerLabel
            app.NumberofPartsSpinnerLabel = uilabel(app.LatticeLayerPropertiesPanel);
            app.NumberofPartsSpinnerLabel.FontSize = 16;
            app.NumberofPartsSpinnerLabel.Position = [10 239 140 22];
            app.NumberofPartsSpinnerLabel.Text = 'Number of Parts';

            % Create LatticePropertiesPanel
            app.LatticePropertiesPanel = uipanel(app.UIFigure);
            app.LatticePropertiesPanel.BorderWidth = 2;
            app.LatticePropertiesPanel.TitlePosition = 'centertop';
            app.LatticePropertiesPanel.Title = '1. Lattice Properties';
            app.LatticePropertiesPanel.BackgroundColor = [1 1 1];
            app.LatticePropertiesPanel.FontWeight = 'bold';
            app.LatticePropertiesPanel.FontSize = 24;
            app.LatticePropertiesPanel.Position = [5 370 385 275];

            % Create CrossSectionDropDownLabel
            app.CrossSectionDropDownLabel = uilabel(app.LatticePropertiesPanel);
            app.CrossSectionDropDownLabel.FontSize = 16;
            app.CrossSectionDropDownLabel.Position = [10 206 105 22];
            app.CrossSectionDropDownLabel.Text = 'Cross Section';

            % Create NumberofLayersSpinnerLabel
            app.NumberofLayersSpinnerLabel = uilabel(app.LatticePropertiesPanel);
            app.NumberofLayersSpinnerLabel.FontSize = 16;
            app.NumberofLayersSpinnerLabel.Position = [10 120 140 22];
            app.NumberofLayersSpinnerLabel.Text = 'Number of Layers';

            % Create ThicknessmmEditFieldLabel
            app.ThicknessmmEditFieldLabel = uilabel(app.LatticePropertiesPanel);
            app.ThicknessmmEditFieldLabel.FontSize = 16;
            app.ThicknessmmEditFieldLabel.Position = [10 90 119 22];
            app.ThicknessmmEditFieldLabel.Text = 'Thickness (mm)';

            % Create ReverseButton
            app.ReverseButton = uibutton(app.LatticePropertiesPanel, 'push');
            app.ReverseButton.ButtonPushedFcn = createCallbackFcn(app, @ReverseButtonPushed, true);
            app.ReverseButton.FontSize = 20;
            app.ReverseButton.Position = [280 10 90 33];
            app.ReverseButton.Text = 'Reverse';

            % Create SaveLatticeButton
            app.SaveLatticeButton = uibutton(app.LatticePropertiesPanel, 'push');
            app.SaveLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLatticeButtonPushed, true);
            app.SaveLatticeButton.FontSize = 20;
            app.SaveLatticeButton.Position = [145 10 125 33];
            app.SaveLatticeButton.Text = 'Save Lattice';

            % Create LoadLatticeButton
            app.LoadLatticeButton = uibutton(app.LatticePropertiesPanel, 'push');
            app.LoadLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @LoadLatticeButtonPushed, true);
            app.LoadLatticeButton.FontSize = 20;
            app.LoadLatticeButton.Position = [10 10 125 33];
            app.LoadLatticeButton.Text = 'Load Lattice';

            % Create FreqUpperBoundSpinner
            app.FreqUpperBoundSpinner = uispinner(app.LatticePropertiesPanel);
            app.FreqUpperBoundSpinner.Step = 50;
            app.FreqUpperBoundSpinner.ValueChangingFcn = createCallbackFcn(app, @FreqUpperBoundSpinnerValueChanging, true);
            app.FreqUpperBoundSpinner.Limits = [50 10000];
            app.FreqUpperBoundSpinner.Tag = 'Frequency_end';
            app.FreqUpperBoundSpinner.HorizontalAlignment = 'center';
            app.FreqUpperBoundSpinner.FontSize = 16;
            app.FreqUpperBoundSpinner.Position = [275 60 75 22];
            app.FreqUpperBoundSpinner.Value = 6300;

            % Create FreqLowerBoundSpinner
            app.FreqLowerBoundSpinner = uispinner(app.LatticePropertiesPanel);
            app.FreqLowerBoundSpinner.Step = 50;
            app.FreqLowerBoundSpinner.ValueChangingFcn = createCallbackFcn(app, @FreqLowerBoundSpinnerValueChanging, true);
            app.FreqLowerBoundSpinner.Limits = [50 10000];
            app.FreqLowerBoundSpinner.HorizontalAlignment = 'center';
            app.FreqLowerBoundSpinner.FontSize = 16;
            app.FreqLowerBoundSpinner.Position = [160 60 75 22];
            app.FreqLowerBoundSpinner.Value = 1000;

            % Create FreqLabel_3
            app.FreqLabel_3 = uilabel(app.LatticePropertiesPanel);
            app.FreqLabel_3.FontSize = 16;
            app.FreqLabel_3.Position = [350 60 20 22];
            app.FreqLabel_3.Text = 'Hz';

            % Create FreqLabel_2
            app.FreqLabel_2 = uilabel(app.LatticePropertiesPanel);
            app.FreqLabel_2.FontSize = 16;
            app.FreqLabel_2.Position = [235 60 40 22];
            app.FreqLabel_2.Text = 'Hz to';

            % Create FreqLabel_1
            app.FreqLabel_1 = uilabel(app.LatticePropertiesPanel);
            app.FreqLabel_1.FontSize = 16;
            app.FreqLabel_1.Position = [10 60 81 22];
            app.FreqLabel_1.Text = 'Frequency';

            % Create ThicknessmmEditField
            app.ThicknessmmEditField = uieditfield(app.LatticePropertiesPanel, 'numeric');
            app.ThicknessmmEditField.Editable = 'off';
            app.ThicknessmmEditField.HorizontalAlignment = 'center';
            app.ThicknessmmEditField.FontSize = 16;
            app.ThicknessmmEditField.Position = [160 90 210 22];
            app.ThicknessmmEditField.Value = 24;

            % Create NumberofLayersSpinner
            app.NumberofLayersSpinner = uispinner(app.LatticePropertiesPanel);
            app.NumberofLayersSpinner.Limits = [1 6];
            app.NumberofLayersSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofLayersSpinnerValueChanged, true);
            app.NumberofLayersSpinner.HorizontalAlignment = 'center';
            app.NumberofLayersSpinner.FontSize = 16;
            app.NumberofLayersSpinner.Position = [160 120 210 22];
            app.NumberofLayersSpinner.Value = 1;

            % Create LengthDiametermmSliderNumeric
            app.LengthDiametermmSliderNumeric = uieditfield(app.LatticePropertiesPanel, 'numeric');
            app.LengthDiametermmSliderNumeric.HorizontalAlignment = 'center';
            app.LengthDiametermmSliderNumeric.FontSize = 16;
            app.LengthDiametermmSliderNumeric.Position = [310 176 60 22];
            app.LengthDiametermmSliderNumeric.Value = 30;

            % Create LengthDiametermmSlider
            app.LengthDiametermmSlider = uislider(app.LatticePropertiesPanel);
            app.LengthDiametermmSlider.Limits = [10 50];
            app.LengthDiametermmSlider.MajorTicks = [10 20 30 40 50];
            app.LengthDiametermmSlider.ValueChangedFcn = createCallbackFcn(app, @LengthDiametermmSliderValueChanged, true);
            app.LengthDiametermmSlider.FontSize = 16;
            app.LengthDiametermmSlider.Position = [160 186 140 3];
            app.LengthDiametermmSlider.Value = 30;

            % Create LengthDiametermmSliderLabel
            app.LengthDiametermmSliderLabel = uilabel(app.LatticePropertiesPanel);
            app.LengthDiametermmSliderLabel.WordWrap = 'on';
            app.LengthDiametermmSliderLabel.FontSize = 16;
            app.LengthDiametermmSliderLabel.Position = [10 150 119 48];
            app.LengthDiametermmSliderLabel.Text = 'Length/Diameter (mm)';

            % Create CrossSectionDropDown
            app.CrossSectionDropDown = uidropdown(app.LatticePropertiesPanel);
            app.CrossSectionDropDown.Items = {'Circular', 'Square'};
            app.CrossSectionDropDown.ValueChangedFcn = createCallbackFcn(app, @CrossSectionDropDownValueChanged, true);
            app.CrossSectionDropDown.FontSize = 16;
            app.CrossSectionDropDown.Position = [160 206 210 22];
            app.CrossSectionDropDown.Value = 'Circular';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LatticeSAC_exported

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
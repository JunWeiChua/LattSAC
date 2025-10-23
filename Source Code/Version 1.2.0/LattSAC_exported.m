classdef LattSAC_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        VersionNum                     matlab.ui.control.Label
        DesignedBy                     matlab.ui.control.Label
        TabGroup                       matlab.ui.container.TabGroup
        LatticePropertiesTab           matlab.ui.container.Tab
        ResetButton                    matlab.ui.control.Button
        RefreshButton                  matlab.ui.control.Button
        PlotSoundAbsorptionButton      matlab.ui.control.Button
        ReverseButton                  matlab.ui.control.Button
        LoadLatticeButton              matlab.ui.control.Button
        Panel_2                        matlab.ui.container.Panel
        GridLayout                     matlab.ui.container.GridLayout
        LayerNumberDropDown            matlab.ui.control.DropDown
        TextAreaP4                     matlab.ui.control.TextArea
        TextAreaP3                     matlab.ui.control.TextArea
        TextAreaP2                     matlab.ui.control.TextArea
        SurfaceRatioSlider_4Label      matlab.ui.control.Label
        SurfaceRatioSlider_3Label      matlab.ui.control.Label
        SurfaceRatioSlider_2Label      matlab.ui.control.Label
        SurfaceRatioSliderLabel        matlab.ui.control.Label
        LayerNumberDropDownLabel       matlab.ui.control.Label
        TextAreaP1                     matlab.ui.control.TextArea
        SurfaceRatioP4                 matlab.ui.control.Slider
        SurfaceRatioP3                 matlab.ui.control.Slider
        SurfaceRatioP2                 matlab.ui.control.Slider
        SurfaceRatioP1                 matlab.ui.control.Slider
        Edit_P4                        matlab.ui.control.Button
        Edit_P3                        matlab.ui.control.Button
        Edit_P2                        matlab.ui.control.Button
        Edit_P1                        matlab.ui.control.Button
        CellTypeP4                     matlab.ui.control.DropDown
        CellTypeP3                     matlab.ui.control.DropDown
        CellTypeP2                     matlab.ui.control.DropDown
        CellTypeP1                     matlab.ui.control.DropDown
        Part4Label                     matlab.ui.control.Label
        Part3Label                     matlab.ui.control.Label
        Part2Label                     matlab.ui.control.Label
        Part1Label                     matlab.ui.control.Label
        Panel                          matlab.ui.container.Panel
        FreqLabel_3                    matlab.ui.control.Label
        FreqUpperBoundSpinner          matlab.ui.control.Spinner
        FreqLabel_2                    matlab.ui.control.Label
        FreqLowerBoundSpinner          matlab.ui.control.Spinner
        FreqLabel_1                    matlab.ui.control.Label
        NumberofLayersSpinner          matlab.ui.control.Spinner
        NumberofLayersSpinnerLabel     matlab.ui.control.Label
        ThicknessmmEditField           matlab.ui.control.NumericEditField
        ThicknessmmEditFieldLabel      matlab.ui.control.Label
        LengthDiametermmSliderNumeric  matlab.ui.control.NumericEditField
        LengthDiametermmSlider         matlab.ui.control.Slider
        LengthDiametermmSliderLabel    matlab.ui.control.Label
        CrossSectionDropDown           matlab.ui.control.DropDown
        CrossSectionDropDownLabel      matlab.ui.control.Label
        FindaLatticeTab                matlab.ui.container.Tab
        UITable                        matlab.ui.control.Table
        ResetFindLattice               matlab.ui.control.Button
        ClearResultsButton             matlab.ui.control.Button
        SaveResultsButton              matlab.ui.control.Button
        PlotSACButtonFindLattice       matlab.ui.control.Button
        FindLatticeButton              matlab.ui.control.Button
        Panel_3                        matlab.ui.container.Panel
        GridLayout2                    matlab.ui.container.GridLayout
        NumberofIterationsFLSpinner    matlab.ui.control.Spinner
        NumberofIterationsFL           matlab.ui.control.Label
        FreqLabelFL3                   matlab.ui.control.Label
        ThicknessmmEditFieldFL         matlab.ui.control.NumericEditField
        ThicknessmmEditFieldFLLabel    matlab.ui.control.Label
        FreqUpperBoundSpinnerFL        matlab.ui.control.Spinner
        FreqLabelFL2                   matlab.ui.control.Label
        FreqLowerBoundSpinnerFL        matlab.ui.control.Spinner
        NumberofLayersSpinnerFL        matlab.ui.control.Spinner
        NumberofLayersSpinnerFLLabel   matlab.ui.control.Label
        FreqLabelFL                    matlab.ui.control.Label
        LengthDiametermmFLSliderNumeric  matlab.ui.control.NumericEditField
        LengthDiametermmFLSlider       matlab.ui.control.Slider
        LengthDiametermmFLSliderLabel  matlab.ui.control.Label
        CrossSectionFLDropDown         matlab.ui.control.DropDown
        CrossSectionFLLabel            matlab.ui.control.Label
        Panel_4                        matlab.ui.container.Panel
        GridLayout_2                   matlab.ui.container.GridLayout
        LayerNumberFLDropDown          matlab.ui.control.DropDown
        LayerNumberDropDown_2Label     matlab.ui.control.Label
        TextAreaFL                     matlab.ui.control.TextArea
        Edit_FL                        matlab.ui.control.Button
        CellTypeFL                     matlab.ui.control.DropDown
        LatticeSACPlotsandDataTab      matlab.ui.container.Tab
        BackButton                     matlab.ui.control.Button
        SaveSACPlotandDataButton       matlab.ui.control.Button
        ExportLatticeDesignButton      matlab.ui.control.Button
        SaveLatticeDesignButton        matlab.ui.control.Button
        FreqBand_4                     matlab.ui.control.NumericEditField
        HzLabel_4                      matlab.ui.control.Label
        FreqBand_3                     matlab.ui.control.NumericEditField
        NRCEditField                   matlab.ui.control.NumericEditField
        HzLabel_3                      matlab.ui.control.Label
        NRCEditFieldLabel              matlab.ui.control.Label
        FreqBand_2                     matlab.ui.control.NumericEditField
        StdDevSACEditField             matlab.ui.control.NumericEditField
        HzLabel_2                      matlab.ui.control.Label
        StdDevSACEditFieldLabel        matlab.ui.control.Label
        FreqBand_1                     matlab.ui.control.NumericEditField
        MeanSACEditField               matlab.ui.control.NumericEditField
        HzLabel_1                      matlab.ui.control.Label
        MeanSACEditFieldLabel          matlab.ui.control.Label
        UIAxes                         matlab.ui.control.UIAxes
        InstructionsTab                matlab.ui.container.Tab
        SpecifyyourLabel_4             matlab.ui.control.Label
        SpecifyyourLabel_3             matlab.ui.control.Label
        SpecifyyourLabel_2             matlab.ui.control.Label
        SpecifyyourLabel               matlab.ui.control.Label
        ExportLatticeDesignLabel       matlab.ui.control.Label
        PlotLatticeSACLabel            matlab.ui.control.Label
        LatticeLayersandPartsLabel     matlab.ui.control.Label
        LatticePropertiesLabel         matlab.ui.control.Label
        Image2                         matlab.ui.control.Image
        AboutThisApplicationTab        matlab.ui.container.Tab
        Image                          matlab.ui.control.Image
        TextArea_2                     matlab.ui.control.TextArea
        ContactsLabel                  matlab.ui.control.Label
        WhatUnitCellDesignsareavailableLabel  matlab.ui.control.Label
        TextArea                       matlab.ui.control.TextArea
        WhatisLattSACLabel             matlab.ui.control.Label
        DesignyourownLatticeSoundAbsorberLabel  matlab.ui.control.Label
        NUSLogo                        matlab.ui.control.Image
        AppTitle                       matlab.ui.control.Label
        ZhaiGroupLogo                  matlab.ui.control.Image
    end

    
    properties (Access = private)
        % Libraries
        CellArchLibrary     % Library of CellArchitecture Objects
        CellArchList        % List of Cell Architectures
        LatticeLibrary      % Library of example Lattice Objects
        LatticeLibraryLabels % Library of example Lattice Objects
        FindLatticeResults  % Library of Lattice Objects from Find Lattice
        
        % Objects containing Lists and Ranges
        LatticeDefault      % Lattice Properties
        StrutDefault        % Strut Lattice
        PlateDefault        % Plate Lattice
        TPMSDefault         % TPMS Lattice
        
        % Lattice Objects
        LatticeStructure    % Lattice Object (Indexed linked list)
        CurrentLayerNum     % Current LattLayer to change
        CurrentLayerNode    % Current LattLayer to change (LLNode)
        CurrentLayer        % Current LattLayer to change (LattLayer)
        CurrentPartNum      % Current LattLayerPart to change
        CurrentPartNode     % Current LattLayerPart to change (LLNode)
        CurrentPart         % Current LattLayerPart to change (LattLayerPart)

        % Lattice Properties
        CrossSection        % Sample Cross Section
        SampleLength        % Sample Length (square cross-section)
        SampleDiameter      % Sample Diameter (circular cross-section)
        NumLayers           % Number of Layers for Sample
        Thickness           % Total thickness of sample
        Frequency           % Frequency Range
        NumParts            % Number of parts for CurrentLayer.
        
        % Bounds Objects (Find Lattice)
        BoundsList          % List of Bounds (Indexed linked list)
        CurrentLayerNum_FL  % Current LattLayer to change
        CurrentLayerNode_FL % Current LattLayer to change (LLNode)
        CurrentLayerBounds_FL % Current LattLayer to change (LattLayer)
        SelectedLattice_FL  % Selected Lattice from FindLatticeResults.

        % Lattice Properties (Find Lattice)
        CrossSection_FL     % Sample Cross Section
        SampleLength_FL     % Sample Length (square cross-section)
        SampleDiameter_FL   % Sample Diameter (circular cross-section)
        NumLayers_FL        % Number of Layers for Sample
        Frequency_FL        % Frequency Range
        Thickness_FL        % Maximum thickness of sample
        Iteration_FL        % Total number of iterations
        CellArch_FL         % List of Cell Types (Cell Array)
        ListTypes_FL        % List of Lattice Types
        LowerBound_FL       % List of Lower Bounds
        UpperBound_FL       % List of Upper Bounds
        IntegerBounds_FL    % List of Integer Bounds
        MinThickness_FL     % Minimum permissible thickness

        % Side Apps
        LattLayerPartProp   % LattLayerPartProperties App
        LattLayerBound      % EditBound App
        LoadLattApp         % Load Lattice App
        SaveLattApp         % Save Lattice App
        ExportLattApp       % Export Lattice App
        SaveSACApp          % Save SAC Plot and Data App
    end
    
    methods (Access = private)
        function resetApp(app)
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Initialising the Application','Indeterminate','on');

            app.importLibraries();
            app.importDefaults();
            app.initialiseLattProp();
            app.initialisePartTable();
            app.initialiseBoundsTable();
            app.createDefaultLatt();
            app.createDefaultBounds();
            app.showResultsTable();
            app.clearSACPlot();
            app.TabGroup.SelectedTab = app.LatticePropertiesTab;

            delete(fig);
        end
        
        function importLibraries(app)
            %#function network
            load('Unit Cell Architecture.mat');
            app.CellArchLibrary = cellArchLib;
            app.CellArchList = cellArchList;
            fprintf('Unit Cell Architecture Library loaded successfully.\n');
            
            load('Lattice Library.mat');
            app.LatticeLibrary = LattLib;
            app.LatticeLibraryLabels = LattLabel;
            fprintf('Lattice Library loaded successfully.\n');
        end

        function importDefaults(app)
            cellTypeList = ["Strut";"Plate";"TPMS"];
            app.LatticeDefault = Default_Lattice(cellTypeList);
            app.StrutDefault = Default_Strut(app.CellArchList{1,1});
            app.PlateDefault = Default_Plate(app.CellArchList{2,1});
            app.TPMSDefault = Default_TPMS(app.CellArchList{3,1},app.CellArchList{3,2});

            fprintf('Default Objects have been created in app.\n');
        end

        function initialiseLattProp(app)
            app.CrossSectionDropDown.Items = app.LatticeDefault.CrossSectionList;
            app.CrossSectionDropDown.Value = app.LatticeDefault.CrossSectionList(1);
            app.CrossSection = app.CrossSectionDropDown.Value;
            
            app.LengthDiametermmSlider.Limits = app.LatticeDefault.SampleLength;
            app.LengthDiametermmSlider.MajorTicks = ...
                app.LatticeDefault.SampleLength(1):10:app.LatticeDefault.SampleLength(2);
            app.LengthDiametermmSlider.MinorTicks = ...
                app.LatticeDefault.SampleLength(1):2:app.LatticeDefault.SampleLength(2);
            app.LengthDiametermmSlider.Value = mean(app.LengthDiametermmSlider.Limits);
            app.LengthDiametermmSliderNumeric.Value = app.LengthDiametermmSlider.Value;
            app.SampleLength = app.LengthDiametermmSlider.Value;
            app.SampleDiameter = app.LengthDiametermmSlider.Value;
            
            app.NumberofLayersSpinner.Value = app.LatticeDefault.NumLayer_0;
            
            app.FreqLowerBoundSpinner.Limits = ...
                [app.LatticeDefault.FrequencyFull(1) app.LatticeDefault.FrequencyFull(end)];
            app.FreqUpperBoundSpinner.Limits = ...
                [app.LatticeDefault.FrequencyFull(1) app.LatticeDefault.FrequencyFull(end)];
            app.FreqLowerBoundSpinner.Value = app.LatticeDefault.Frequency(1);
            app.FreqUpperBoundSpinner.Value = app.LatticeDefault.Frequency(end);

            fprintf('Lattice Properties has been initialised.\n');

            app.CrossSectionFLDropDown.Items = app.LatticeDefault.CrossSectionList;
            app.CrossSectionFLDropDown.Value = app.LatticeDefault.CrossSectionList(1);
            app.CrossSection_FL = app.CrossSectionFLDropDown.Value;
            
            app.LengthDiametermmFLSlider.Limits = app.LatticeDefault.SampleLength;
            app.LengthDiametermmFLSlider.MajorTicks = ...
                app.LatticeDefault.SampleLength(1):10:app.LatticeDefault.SampleLength(2);
            app.LengthDiametermmFLSlider.MinorTicks = ...
                app.LatticeDefault.SampleLength(1):2:app.LatticeDefault.SampleLength(2);
            app.LengthDiametermmFLSlider.Value = mean(app.LengthDiametermmFLSlider.Limits);
            app.LengthDiametermmFLSliderNumeric.Value = app.LengthDiametermmFLSlider.Value;
            app.SampleLength_FL = app.LengthDiametermmFLSlider.Value;
            app.SampleDiameter_FL = app.LengthDiametermmFLSlider.Value;
            
            app.NumberofLayersSpinnerFL.Value = app.LatticeDefault.NumLayer_0;
            app.NumLayers_FL = app.LatticeDefault.NumLayer_0;

            app.FreqLowerBoundSpinnerFL.Limits = ...
                [app.LatticeDefault.FrequencyFull(1) app.LatticeDefault.FrequencyFull(end)];
            app.FreqUpperBoundSpinnerFL.Limits = ...
                [app.LatticeDefault.FrequencyFull(1) app.LatticeDefault.FrequencyFull(end)];
            app.FreqLowerBoundSpinnerFL.Value = app.LatticeDefault.Frequency(1);
            app.FreqUpperBoundSpinnerFL.Value = app.LatticeDefault.Frequency(end);
            app.Frequency_FL = app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;

            app.ThicknessmmEditFieldFL.Value = app.LatticeDefault.MaxThickness_0;
            app.Thickness_FL = app.ThicknessmmEditFieldFL.Value;

            app.NumberofIterationsFLSpinner.Limits = ...
                [app.LatticeDefault.NumIter(1) app.LatticeDefault.NumIter(end)];
            app.NumberofIterationsFLSpinner.Value = app.LatticeDefault.NumIter_0;
            app.Iteration_FL = app.NumberofIterationsFLSpinner.Value;

            fprintf('Lattice Properties (Find Lattice) has been initialised.\n');
        end
        
        function initialisePartTable(app)
            app.CellTypeP1.Items = [app.LatticeDefault.CellType];
            app.CellTypeP2.Items = ["Choose Cell Type"; app.LatticeDefault.CellType];
            app.CellTypeP3.Items = ["Choose Cell Type"; app.LatticeDefault.CellType];
            app.CellTypeP4.Items = ["Choose Cell Type"; app.LatticeDefault.CellType];

            app.CellTypeP1.Value = app.CellTypeP1.Items(1);
            app.CellTypeP2.Value = app.CellTypeP2.Items(1);
            app.CellTypeP3.Value = app.CellTypeP3.Items(1);
            app.CellTypeP4.Value = app.CellTypeP4.Items(1);

            app.SurfaceRatioP1.Value = 1;
            app.SurfaceRatioP2.Value = 0;
            app.SurfaceRatioP3.Value = 0;
            app.SurfaceRatioP4.Value = 0;

            app.CellTypeP2.Enable = 'on';
            app.CellTypeP3.Enable = 'off';
            app.CellTypeP4.Enable = 'off';

            app.Edit_P2.Enable = 'off';
            app.Edit_P3.Enable = 'off';
            app.Edit_P4.Enable = 'off';

            app.SurfaceRatioP2.Enable = 'off';
            app.SurfaceRatioP3.Enable = 'off';
            app.SurfaceRatioP4.Enable = 'off';

            app.TextAreaP1.Value = '';
            app.TextAreaP2.Value = '';
            app.TextAreaP3.Value = '';
            app.TextAreaP4.Value = '';

            fprintf('Lattice Part Table has been initialised.\n');
        end

        function initialiseBoundsTable(app)
            app.CellTypeFL.Items = [app.LatticeDefault.CellType];
            app.CellTypeFL.Value = app.CellTypeFL.Items(1);
            app.TextAreaFL.Value = '';

            fprintf('Lattice Bounds Table has been initialised.\n');
        end

        function createDefaultLatt(app)
            % Initialise first LattLayer.
            app.CurrentLayerNum = 1;
            app.LayerNumberDropDown.Value = app.LayerNumberDropDown.Items(1);
            app.createLayer();

            % Initialise LatticeStructure.
            app.LatticeStructure = Lattice(app.CrossSection, ...
                app.LatticeDefault.FrequencyFull);
            app.LatticeStructure.insertLayer(app.CurrentLayer,app.CurrentLayerNum);
            fprintf('New Lattice has been Created.\n');

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure);
        end

        % Create new LattLayer.
        function createLayer(app)
            % Initialise first LattLayerPart.
            app.CurrentPartNum = 1;
            app.createPart("Strut");
            
            % Initialise new LattLayer.
            app.CurrentLayer = LattLayer(app.CrossSection, ...
                app.LatticeDefault.FrequencyFull);
            app.CurrentLayer.insertPart(app.CurrentPart,1);
            app.CurrentPartNode = app.CurrentLayer.Head;

            fprintf('New Lattice Layer has been created.\n');
        end

        % Create new LattLayerPart.
        function createPart(app,CellType)
            Strut_0 = app.StrutDefault;
            Plate_0 = app.PlateDefault;
            TPMS_0 = app.TPMSDefault;

            switch CellType
                case "Strut"
                    app.CurrentPart = LattPartStrut(Strut_0.CellArch_0, ...
                        Strut_0.CellSize_0, ...
                        Strut_0.RelativeDensity_0, ...
                        app.CrossSection,...
                        app.SampleLength,...
                        app.SampleDiameter,...
                        Strut_0.NumLayer_0);
                case "Plate"
                    app.CurrentPart = LattPartPlate(Plate_0.CellArch_0, ...
                        Plate_0.CellSize_0, ...
                        Plate_0.RelativeDensity_0, ...
                        Plate_0.HolePercent_0, ...
                        app.CrossSection,...
                        app.SampleLength,...
                        app.SampleDiameter,...
                        Plate_0.NumLayer_0);
                case "TPMS"
                    app.CurrentPart = LattPartTPMS(TPMS_0.CellArch_0, ...
                        TPMS_0.Network_0, ...
                        TPMS_0.CellSize_0, ...
                        TPMS_0.RelativeDensity_0, ...
                        app.CrossSection,...
                        app.SampleLength,...
                        app.SampleDiameter,...
                        TPMS_0.NumLayer_0);
            end
            fprintf('Part of Type %s has been Created.\n',CellType);
        end

        function editPart(app,PartNum,CellType)
            app.CurrentPartNum = PartNum;
            app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
            app.CurrentPart = app.CurrentPartNode.Data;

            switch CellType
                case "Strut"
                    app.LattLayerPartProp = ...
                        EditPartStrut(app,app.CurrentPart,app.StrutDefault);
                case "Plate"
                    app.LattLayerPartProp = ...
                        EditPartPlate(app,app.CurrentPart,app.PlateDefault);
                case "TPMS"
                    app.LattLayerPartProp = ...
                        EditPartTPMS(app,app.CurrentPart,app.TPMSDefault);
            end
            fprintf('Part Number %d of Lattice Layer %d has been edited.\n',...
                PartNum,app.CurrentPartNum);
        end

        function editPartSR(app,PartNum,newSR)
            app.CurrentPartNum = PartNum;
            app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
            app.CurrentPart = app.CurrentPartNode.Data;

            app.CurrentPart.setSR(newSR);
            app.showParts(app.CurrentLayer);
            fprintf('Surface Ratio of Part Number %d changed to %d.\n',PartNum,newSR);
        end

        function updateLattice(app)
            app.LatticeStructure.updateThickness(1);
            app.LatticeStructure.updatePorosity();
            app.LatticeStructure.updateSurfaceRatio();
            app.loadLattice(app.LatticeStructure);
        end

        % Create new BoundsList.
        function createDefaultBounds(app)
            % Initialise first Bounds Layer.
            app.CurrentLayerNum_FL = 1;
            app.LayerNumberFLDropDown.Value = app.LayerNumberFLDropDown.Items(1);
            app.createBounds("Strut");

            % Initialise BoundsList.
            app.BoundsList = LinkedList();
            app.BoundsList.insert(app.CurrentLayerBounds_FL,app.CurrentLayerNum_FL);
            fprintf('New Bounds List has been Created.\n');

            % Set all properties on UI and main app.
            app.loadBounds(app.BoundsList);

            % Initialise FindLatticeResults
            app.FindLatticeResults = LatticeLib();
            app.showResultsTable();
            app.SelectedLattice_FL = [];
        end

        % Create new Bounds.
        function createBounds(app,CellType)
            app.StrutDefault = Default_Strut(app.CellArchList{1,1});
            app.PlateDefault = Default_Plate(app.CellArchList{2,1});
            app.TPMSDefault = Default_TPMS(app.CellArchList{3,1},app.CellArchList{3,2});
            
            switch CellType
                case "Strut"
                    app.CurrentLayerBounds_FL = ...
                        Default_Strut(app.CellArchList{1,1});
                case "Plate"
                    app.CurrentLayerBounds_FL = ...
                        Default_Plate(app.CellArchList{2,1});
                case "TPMS"
                    app.CurrentLayerBounds_FL = ...
                        Default_TPMS(app.CellArchList{3,1},app.CellArchList{3,2});
            end
            fprintf('New Bounds Layer of Type %s has been created.\n',CellType);
        end

        function compileConstraints(app)
            app.CellArch_FL = cell(app.NumLayers_FL,2);
            app.ListTypes_FL = [];
            app.LowerBound_FL = [];
            app.UpperBound_FL = [];
            app.IntegerBounds_FL = [];
            app.MinThickness_FL = 0;
            ParamIdx = 0;

            for idx_layer = 1:app.NumLayers_FL
	            Node = app.BoundsList.getNode(idx_layer);
                Bounds = Node.Data;
                Type = Bounds.CellType;
                app.ListTypes_FL = [app.ListTypes_FL; Type];
                app.MinThickness_FL = app.MinThickness_FL + ...
                    Bounds.CellSize_Min*Bounds.NumLayer_Min;
                switch Type
		            case 'Strut'
			            app.CellArch_FL{idx_layer,1} = Bounds.CellArch_Choices;
                        app.LowerBound_FL = [app.LowerBound_FL; ...
                            [1; ...
                            Bounds.CellSize_Min; ...
                            Bounds.RelativeDensity_Min; ...
                            Bounds.NumLayer_Min]];
			            app.UpperBound_FL = [app.UpperBound_FL; ...
                            [length(Bounds.CellArch_Choices); ...
                            Bounds.CellSize_Max; ...
                            Bounds.RelativeDensity_Max; ...
                            10]];
			            app.IntegerBounds_FL = [app.IntegerBounds_FL ...
                            [ParamIdx+1 ParamIdx+4]];
			            
			            ParamIdx = ParamIdx + 4;
		            case 'Plate'
			            app.CellArch_FL{idx_layer,1} = Bounds.CellArch_Choices;
                        app.LowerBound_FL = [app.LowerBound_FL; ...
                            [1; ...
                            Bounds.CellSize_Min; ...
                            Bounds.RelativeDensity_Min; ...
                            Bounds.HolePercent_Min; ...
                            Bounds.NumLayer_Min]];
			            app.UpperBound_FL = [app.UpperBound_FL; ...
                            [length(Bounds.CellArch_Choices); ...
                            Bounds.CellSize_Max; ...
                            Bounds.RelativeDensity_Max; ...
                            Bounds.HolePercent_Max; ...
                            10]];
			            app.IntegerBounds_FL = [app.IntegerBounds_FL ...
                            [ParamIdx+1 ParamIdx+5]];
			            
			            ParamIdx = ParamIdx + 5;
		            case 'TPMS'
			            app.CellArch_FL{idx_layer,1} = Bounds.CellArch_Choices;
                        app.CellArch_FL{idx_layer,2} = Bounds.Network_Choices;
                        app.LowerBound_FL = [app.LowerBound_FL; ...
                            [1; ...
                            1; ...
                            Bounds.CellSize_Min; ...
                            Bounds.RelativeDensity_Min; ...
                            Bounds.NumLayer_Min]];
			            app.UpperBound_FL = [app.UpperBound_FL; ...
                            [length(Bounds.CellArch_Choices); ...
                            length(Bounds.Network_Choices); ...
                            Bounds.CellSize_Max; ...
                            Bounds.RelativeDensity_Max; ...
                            10]];
			            app.IntegerBounds_FL = [app.IntegerBounds_FL ...
                            [ParamIdx+1 ParamIdx+2 ParamIdx+5]];
			            
			            ParamIdx = ParamIdx + 5;
                end
            end
        end

        function findLattice(app)
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Finding your Lattice(s). This may take a while...', ...
                'Indeterminate','on');
            
            app.FindLatticeResults = OptimizeSAC(app.ListTypes_FL, ...
                app.CellArch_FL,app.Frequency_FL, ...
                app.LatticeDefault.FrequencyFull,app.CrossSection_FL, ...
                app.SampleDiameter_FL,app.Thickness_FL, ...
                app.LowerBound_FL,app.UpperBound_FL,app.IntegerBounds_FL,...
                app.Iteration_FL);
            delete(fig);

            fig = uifigure('Position',[250 400 300 170]);
            if app.FindLatticeResults.Length > 0
                uialert(fig,"At least one solution found.","Solution Found.", ...
                    "Icon","success");
                app.showResultsTable();
            else
                uialert(fig,"No solutions have been found.","No Solutions Found.", ...
                    "Icon","error");
            end
        end

        % Plot sound absorption coefficient on axes.
        function plotSAC(app)
            color = [0 0.8 0; 0.8 0 0; 0 0 0.8; 0.8 0.6 0];
            line_style = ["--" ":" "-" "-."];
            marker = ['o','+','x','s'];
            
            plot(app.UIAxes,app.LatticeDefault.FrequencyFull,app.LatticeStructure.SAC, ...
                'DisplayName','Lattice SAC', ...
				'Color',[0 0 0.8],'LineStyle',"-",'LineWidth',2);
            
	        app.UIAxes.XLim = [app.Frequency(1) app.Frequency(end)];
	        app.UIAxes.YLim = [0 1];
	        app.UIAxes.YTick = 0:0.2:1.0;
	        legend(app.UIAxes,'Location','northeast','NumColumns',1);
	        legend(app.UIAxes,'FontSize',16);
	        legend(app.UIAxes,'boxoff');

            fprintf('SAC of Lattice Structure has been plotted.\n');

            calcSACstats(app);
        end

        % Show SAC stats in UI.
        function calcSACstats(app)
            freq = app.LatticeDefault.FrequencyFull;
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

            fprintf('SAC stats of Lattice Structure has been calculated.\n');
        end
        
        % Clear plot axes
        function clearSACPlot(app)
            cla(app.UIAxes);
            app.MeanSACEditField.Value = 0;
	        app.StdDevSACEditField.Value = 0;
	        app.NRCEditField.Value = 0;
	        app.FreqBand_1.Value = 0;
	        app.FreqBand_2.Value = 0;
            app.FreqBand_3.Value = 0;
	        app.FreqBand_4.Value = 0;

            fprintf('SAC Plot has been cleared.\n');
        end
    end
    
    methods (Access = public)
        % Load the current LatticeStructure
        function loadLattice(app,Lattice)
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
                find(app.LatticeDefault.CrossSectionList == Lattice.CrossSection);
            app.CrossSectionDropDown.Value = ...
                app.CrossSectionDropDown.Items(CrossSectionNum);
            app.LengthDiametermmSlider.Value = Lattice.l_sample;
            app.LengthDiametermmSliderNumeric.Value = ...
                app.LengthDiametermmSlider.Value;
            app.NumberofLayersSpinner.Value = Lattice.num_layers;
            app.showParts(app.CurrentLayer);

            % Set the properties within the main app.
            app.CrossSection = app.CrossSectionDropDown.Value;
            app.SampleLength = app.LengthDiametermmSlider.Value;
            app.SampleDiameter = app.LengthDiametermmSlider.Value;
            app.NumLayers = app.NumberofLayersSpinner.Value;
            app.NumParts = app.CurrentLayer.Length;
            app.LayerNumberDropDown.Items = string(1:app.NumLayers);
            app.LayerNumberDropDown.Value = ...
                app.LayerNumberDropDown.Items(app.CurrentLayerNum);
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            app.Thickness = app.LatticeStructure.t_sample;
            app.ThicknessmmEditField.Value = app.Thickness;

            fprintf('Lattice Structure has been loaded.\n');
        end

        % Update part information.
        function showParts(app,layer)
            app.initialisePartTable();
            cur = layer.Head;
            while ~isempty(cur)
                part = cur.Data;
                cellTypeIdx = find(app.LatticeDefault.CellType==part.UnitCell.CellArch.CellType);
                switch cur.Index
                    case 1
                        app.CellTypeP1.Value = app.CellTypeP1.Items(cellTypeIdx);
                        app.SurfaceRatioP1.Value = part.SurfaceRatio;
                        app.displayPartInfo(part,app.TextAreaP1);
                    case 2
                        app.CellTypeP2.Value = app.CellTypeP2.Items(cellTypeIdx+1);
                        app.SurfaceRatioP2.Value = part.SurfaceRatio;
                        app.displayPartInfo(part,app.TextAreaP2);
                        app.Edit_P2.Enable = 'on';
                        app.SurfaceRatioP2.Enable = 'on';
                        app.CellTypeP3.Enable = 'on';
                    case 3
                        app.CellTypeP3.Value = app.CellTypeP3.Items(cellTypeIdx+1);
                        app.SurfaceRatioP3.Value = part.SurfaceRatio;
                        app.displayPartInfo(part,app.TextAreaP3);
                        app.Edit_P3.Enable = 'on';
                        app.SurfaceRatioP3.Enable = 'on';
                        app.CellTypeP4.Enable = 'on';
                    case 4
                        app.CellTypeP4.Value = app.CellTypeP4.Items(cellTypeIdx+1);
                        app.SurfaceRatioP4.Value = part.SurfaceRatio;
                        app.displayPartInfo(part,app.TextAreaP4);
                        app.Edit_P4.Enable = 'on';
                        app.SurfaceRatioP4.Enable = 'on';
                end
                fprintf('Part %d of Type %s has been displayed.\n',...
                    cur.Index,part.UnitCell.CellArch.CellType);
                cur = cur.Next;
            end
            fprintf('Parts for Current Layer has been loaded.\n');
        end

        function displayPartInfo(app,part,textbox)
            switch part.UnitCell.CellArch.CellType
                case "Strut"
                    app.showPartStrut(part,textbox);
                case "Plate"
                    app.showPartPlate(part,textbox);
                case "TPMS"
                    app.showPartTPMS(part,textbox);
            end
        end

        function showPartStrut(~,part,textbox)
            textbox.Value = { ...
                sprintf('Unit Cell: %s',part.UnitCell.CellArch.Name); ...
                sprintf('Cell Type: %s',part.UnitCell.CellArch.CellType); ...
		        sprintf('Cell Length: %.5f',part.UnitCell.cell_length); ...
		        sprintf('Rel Density: %.5f',part.UnitCell.rel_density); ...
		        sprintf('Strut Length: %.5f',part.UnitCell.strut_length); ...
		        sprintf('Strut Width: %.5f',part.UnitCell.strut_width); ...
                sprintf('Strut Width (1mm): %.5f',part.UnitCell.strut_width/part.UnitCell.cell_length); ...
		        sprintf('Number of layers: %d',part.N_z); ...
                sprintf('Surface Ratio: %.3f',part.SurfaceRatio); ...
                };
        end

        function showPartPlate(~,part,textbox)
            textbox.Value = {...
                sprintf('Unit Cell: %s',part.UnitCell.CellArch.Name); ...
			    sprintf('Cell Type: %s',part.UnitCell.CellArch.CellType); ...
			    sprintf('Cell Length: %.5f',part.UnitCell.cell_length); ...
			    sprintf('Rel Density: %.5f',part.UnitCell.rel_density); ...
			    sprintf('Hole Diameter: %.5f',part.UnitCell.d_hole); ...
			    sprintf('Hole Diameter (1mm): %.5f',part.UnitCell.d_hole/part.UnitCell.cell_length); ...
                sprintf('Plate Thickness: %.5f',part.UnitCell.t_plate); ...
			    sprintf('Plate Thickness (1mm): %.5f',part.UnitCell.t_plate/part.UnitCell.cell_length); ...
			    sprintf('Cross Section: %s',part.CrossSection); ...
			    sprintf('Number of layers: %d',part.N_z); ...
			    sprintf('Surface Ratio: %.3f',part.SurfaceRatio); ...
                };
        end

        function showPartTPMS(~,part,textbox)
            textbox.Value = {...
                sprintf('Cell Type: %s',part.UnitCell.CellArch.CellType); ...
                sprintf('Unit Cell: %s',part.UnitCell.CellArch.Name); ...
                sprintf('Network: %s',part.UnitCell.CellArch.Network); ...
		        sprintf('Cell Length: %.5f',part.UnitCell.cell_length); ...
		        sprintf('Rel Density: %.5f',part.UnitCell.rel_density); ...
		        sprintf('Isovalue: %.5f',part.UnitCell.isovalue); ...
		        sprintf('Number of layers: %d',part.N_z); ...
                sprintf('Surface Ratio: %.3f',part.SurfaceRatio); ...
                };
        end

        % Update Lattice Library and Labels
        function updateLattLib(app,LattLibrary,LattLibraryLabel)
            app.LatticeLibrary = LattLibrary;
            app.LatticeLibraryLabels = LattLibraryLabel;
            LattLib = app.LatticeLibrary;
            LattLabel = app.LatticeLibraryLabels;
            save('Lattice Library.mat','LattLib','LattLabel');
            fprintf('Lattice Library has been updated.\n');
        end

        % Updates Main App after Exiting from LoadLatt App.
        function loadLatt(app,Lattice)
            % Update the LatticeStructure in the main app.
            app.LatticeStructure = Lattice.copyLatt();

            % Update Lattice Properties of main app
            app.updateLattice();
            fprintf('Lattice Structure has been loaded from Library.\n');
        end

        % Save Lattice into Lattice Library
        function saveLatt(app,Name,Object)
            switch Object
                case "LatticeStructure"
                    app.LatticeLibrary.insert(app.LatticeStructure,app.LatticeLibrary.Length+1);
			        app.LatticeLibraryLabels.insert(Name,app.LatticeLibraryLabels.Length+1);
                    
                    fprintf('Lattice Structure %s saved into Lattice Library.\n',Name);
                case "LatticeLibrary"
                    cur = app.FindLatticeResults.Head; count = 0;
                    while ~isempty(cur)
                        Lattice = cur.Data; count = count + 1;
                        ResultName = sprintf("%s_%d",Name,count);
                        app.LatticeLibrary.insert(Lattice,app.LatticeLibrary.Length+1);
			            app.LatticeLibraryLabels.insert(ResultName,app.LatticeLibraryLabels.Length+1);
                        
                        fprintf('Lattice Structure %s saved into Lattice Library.\n',ResultName);
                        cur = cur.Next;
                    end
            end
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
            app.Thickness = app.LatticeStructure.t_sample;
            app.ThicknessmmEditField.Value = app.Thickness;
            app.showParts(app.CurrentLayer);
        end

        % Load the current BoundsList
        function loadBounds(app,BoundsList)
            % CurrentLayerFL is set to be the first layer of BoundsList.
            app.CurrentLayerNum_FL = 1;
            app.CurrentLayerNode_FL = BoundsList.Head;
            app.CurrentLayerBounds_FL = app.CurrentLayerNode_FL.Data;
            app.showBounds(app.CurrentLayerBounds_FL);

            % Set the properties within the main app.
            app.CrossSection_FL = app.CrossSectionFLDropDown.Value;
            app.SampleLength_FL = app.LengthDiametermmFLSlider.Value;
            app.SampleDiameter_FL = app.LengthDiametermmFLSlider.Value;
            app.NumLayers_FL = app.BoundsList.Length;
            app.LayerNumberFLDropDown.Items = string(1:app.NumLayers_FL);
            app.LayerNumberFLDropDown.Value = ...
                app.LayerNumberFLDropDown.Items(app.CurrentLayerNum_FL);
            app.Frequency_FL = app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;
            app.Thickness_FL = app.ThicknessmmEditFieldFL.Value;
            app.Iteration_FL = app.NumberofIterationsFLSpinner.Value;
            
            fprintf('Bounds List has been loaded.\n');
        end
        
        % Update bounds information.
        function showBounds(app,Bound)
            app.initialiseBoundsTable();
            
            cellTypeIdx = find(app.LatticeDefault.CellType==Bound.CellType);
            app.CellTypeFL.Value = app.CellTypeFL.Items(cellTypeIdx);
            app.displayBoundsInfo(Bound,app.TextAreaFL);
        end

        function displayBoundsInfo(app,bound,textbox)
            switch bound.CellType
                case "Strut"
                    app.showBoundsStrut(bound,textbox);
                case "Plate"
                    app.showBoundsPlate(bound,textbox);
                case "TPMS"
                    app.showBoundsTPMS(bound,textbox);
            end
        end

        function showBoundsStrut(~,bound,textbox)
            textbox.Value = { ...
                sprintf('Cell Type: %s',bound.CellType); ...
                % sprintf('Unit Cell: %s',bound.CellArch_Choices); ...
                sprintf('Cell Length: %.5f to %.5f',bound.CellSize_Min,bound.CellSize_Max); ...
		        sprintf('Rel Density: %.5f to %.5f',bound.RelativeDensity_Min,bound.RelativeDensity_Max); ...
		        sprintf('Min Number of Layers: %d',bound.NumLayer_Min); ...
                };
        end

        function showBoundsPlate(~,bound,textbox)
            textbox.Value = {...
                sprintf('Cell Type: %s',bound.CellType); ...
		        % sprintf('Unit Cell: %s',bound.CellArch_Choices); ...
                sprintf('Cell Length: %.5f to %.5f',bound.CellSize_Min,bound.CellSize_Max); ...
		        sprintf('Rel Density: %.5f to %.5f',bound.RelativeDensity_Min,bound.RelativeDensity_Max); ...
                sprintf('Hole Diameter: %.5f to %.5f',bound.HolePercent_Min,bound.HolePercent_Max); ...
		        sprintf('Min Number of Layers: %d',bound.NumLayer_Min); ...
                };
        end

        function showBoundsTPMS(~,bound,textbox)
            textbox.Value = {...
                sprintf('Cell Type: %s',bound.CellType); ...
		        % sprintf('Unit Cell: %s',bound.CellArch_Choices); ...
                % sprintf('Network: %s',bound.Network_Choices); ...
                sprintf('Cell Length: %.5f to %.5f',bound.CellSize_Min,bound.CellSize_Max); ...
		        sprintf('Rel Density: %.5f to %.5f',bound.RelativeDensity_Min,bound.RelativeDensity_Max); ...
		        sprintf('Min Number of Layers: %d',bound.NumLayer_Min); ...
                };
        end

        % Updates Main App after Exiting from EditBound App.
        function updateBounds(app,NewBounds)
            % Update the BoundsList in the main app.
            app.BoundsList.remove(app.CurrentLayerNum_FL);
            app.BoundsList.insert(NewBounds,app.CurrentLayerNum_FL);
            
            app.CurrentLayerBounds_FL = NewBounds;
            app.showBounds(app.CurrentLayerBounds_FL);
        end

        function editBounds(app,CellType)
            switch CellType
                case "Strut"
                    app.LattLayerBound = ...
                        EditBoundStrut(app,app.CurrentLayerBounds_FL,app.StrutDefault);
                case "Plate"
                    app.LattLayerBound = ...
                        EditBoundPlate(app,app.CurrentLayerBounds_FL,app.PlateDefault);
                case "TPMS"
                    app.LattLayerBound = ...
                        EditBoundTPMS(app,app.CurrentLayerBounds_FL,app.TPMSDefault);
            end
            fprintf('Bounds of Layer %d has been edited.\n',...
                app.CurrentLayerNum_FL);
        end

        function showResultsTable(app)
            % Create new LattResultsTable.
            LattResultsTable = [];
            LattResultsTable = table('Size',[0 3],...
                'VariableTypes',["string","double","double"], ...
                'VariableNames',["Name","Thickness","Mean SAC"]);
            
            % Add rows for LattResultsTable.
            cur = app.FindLatticeResults.Head; count = 0;
            while ~isempty(cur)
                latt = cur.Data; count = count + 1;
                name = sprintf("Result %d",count);
                LattResultsTable(count,:) = ...
                    {name,latt.t_sample,mean(latt.SAC)};
                cur = cur.Next;
            end
            
            % Show LattLayerPartTable on UI.
            app.UITable.Data = LattResultsTable;
            app.UITable.RowName = 'numbered';
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.resetApp();
        end

        % Value changed function: CrossSectionDropDown
        function CrossSectionDropDownValueChanged(app, event)
            value = app.CrossSectionDropDown.Value;
            fprintf('USER: Change Lattice Cross Section to %s.\n',value);

            app.LatticeStructure.changeParam(value, ...
                app.LatticeStructure.l_sample, ...
                app.LatticeStructure.w_sample);

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure);

            fprintf('Lattice Cross Section changed to %s.\n',value);

            % For now, changing the cross section of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: LengthDiametermmSlider
        function LengthDiametermmSliderValueChanged(app, event)
            value = app.LengthDiametermmSlider.Value;
            fprintf('USER: Change Lattice Length or Diameter to %d.\n',value);
            
            app.LatticeStructure.changeParam(app.CrossSection, ...
                value,value);

            % Set all properties on UI and main app.
            app.loadLattice(app.LatticeStructure);

            fprintf('Lattice Length or Diameter changed to %d.\n',value);
            
            % For now, changing the length/diameter of the lattice and the
            % lattice layers has no effect. In the future, this may affect
            % the correction factors to be used in the calculation of sound
            % absorption.
        end

        % Value changed function: NumberofLayersSpinner
        function NumberofLayersSpinnerValueChanged(app, event)
            value = app.NumberofLayersSpinner.Value;
            fprintf('USER: Change Number of Layers to %d.\n',value);
            
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Changing Number of Layers','Indeterminate','on');

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
            app.LatticeStructure.updateThickness(0);
            app.loadLattice(app.LatticeStructure);
            fprintf('Number of Lattice Layers changed to %d.\n',value);
            delete(fig);
        end

        % Value changing function: NumberofLayersSpinner
        function NumberofLayersSpinnerValueChanging(app, event)
            value = event.Value;
            fprintf('USER: Change Number of Layers to %d.\n',value);

            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Changing Number of Layers','Indeterminate','on');

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
            app.LatticeStructure.updateThickness(0);
            app.loadLattice(app.LatticeStructure);
            fprintf('Number of Lattice Layers changed to %d.\n',value);
            delete(fig);
        end

        % Value changing function: FreqLowerBoundSpinner
        function FreqLowerBoundSpinnerValueChanging(app, event)
            changingValue = event.Value;
            fprintf('USER: Change Frequency Range to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);

            if app.FreqUpperBoundSpinner.Value < changingValue + 100
                app.FreqUpperBoundSpinner.Value = ...
                    min([changingValue + 100,app.FreqUpperBoundSpinner.Limits(2)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            fprintf('Frequency Range changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);
        end

        % Value changing function: FreqUpperBoundSpinner
        function FreqUpperBoundSpinnerValueChanging(app, event)
            changingValue = event.Value;
            fprintf('USER: Change Frequency Range to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);

            if app.FreqLowerBoundSpinner.Value > changingValue - 100
                app.FreqLowerBoundSpinner.Value = ...
                    max([changingValue - 100,app.FreqLowerBoundSpinner.Limits(1)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            fprintf('Frequency Range changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);
        end

        % Value changed function: FreqLowerBoundSpinner
        function FreqLowerBoundSpinnerValueChanged(app, event)
            value = app.FreqLowerBoundSpinner.Value;
            fprintf('USER: Change Frequency Range to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);

            if app.FreqUpperBoundSpinner.Value < value + 100
                app.FreqUpperBoundSpinner.Value = ...
                    min([changingValue + 100,app.FreqUpperBoundSpinner.Limits(2)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            fprintf('Frequency Range changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);
        end

        % Value changed function: FreqUpperBoundSpinner
        function FreqUpperBoundSpinnerValueChanged(app, event)
            value = app.FreqUpperBoundSpinner.Value;
            fprintf('USER: Change Frequency Range to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);

            if app.FreqLowerBoundSpinner.Value > value - 100
                app.FreqLowerBoundSpinner.Value = ...
                    max([changingValue - 100,app.FreqLowerBoundSpinner.Limits(1)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinner.Value:10:app.FreqUpperBoundSpinner.Value;
            fprintf('Frequency Range changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinner.Value,app.FreqUpperBoundSpinner.Value);
        end

        % Button pushed function: LoadLatticeButton
        function LoadLatticeButtonPushed(app, event)
            fprintf('USER: Load Lattice from Library.\n');
            app.LoadLattApp = LoadLatt(app,app.LatticeLibrary,app.LatticeLibraryLabels);
            fprintf('Lattice Loaded from Library.\n');
        end

        % Button pushed function: ReverseButton
        function ReverseButtonPushed(app, event)
            fprintf('USER: Reverse the Lattice Orientation.\n');
            app.LatticeStructure.reverseLatt();
            
            % Refresh all properties on UI and main app.
            app.updateLattice();
            fprintf('Lattice Orientation has been reversed.\n');
        end

        % Value changed function: LayerNumberDropDown
        function LayerNumberDropDownValueChanged(app, event)
            value = app.LayerNumberDropDown.Value;
            fprintf('USER: Change Layer Number to %s.\n',value);

            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Loading Layer Information','Indeterminate','on');

            app.CurrentLayerNum = str2double(value);
            app.CurrentLayerNode = app.LatticeStructure.getNode(app.CurrentLayerNum);
            app.CurrentLayer = app.CurrentLayerNode.Data;
            
            app.NumParts = app.CurrentLayer.Length;
            
            app.CurrentPartNum = 1;
            app.CurrentPartNode = app.CurrentLayer.Head;
            app.CurrentPart = app.CurrentPartNode.Data;

            % Update Part Information
            app.showParts(app.CurrentLayer);
            fprintf('Current Layer changed to %d.\n',app.CurrentLayerNum);
            delete(fig);
        end

        % Value changed function: CellTypeP1
        function CellTypeP1ValueChanged(app, event)
            app.CurrentPartNum = 1; Edited = false;
            fprintf('USER: Change the Cell Type of Part 1 to %s.\n',app.CellTypeP1.Value);

            switch app.CellTypeP1.Value
                case "Strut"
                    app.createPart("Strut");
                    app.Edit_P1.Enable = 'on';
                    app.SurfaceRatioP1.Enable = 'on';
                    app.CellTypeP2.Enable = 'on';
                    Edited = true;
                case "Plate"
                    app.createPart("Plate");
                    app.Edit_P1.Enable = 'on';
                    app.SurfaceRatioP1.Enable = 'on';
                    app.CellTypeP2.Enable = 'on';
                    Edited = true;
                case "TPMS"
                    app.createPart("TPMS");
                    app.Edit_P1.Enable = 'on';
                    app.SurfaceRatioP1.Enable = 'on';
                    app.CellTypeP2.Enable = 'on';
                    Edited = true;
            end

            if Edited == true
                if app.CurrentPartNum <= app.NumParts
                    app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
                    % app.CurrentPart = app.CurrentPartNode.Data;
                    app.updatePart(app.CurrentPart);
                else
                    app.CurrentLayer.insert(app.CurrentPart,app.CurrentPartNum);
                    app.NumParts = app.CurrentLayer.Length;
                end
                fprintf('Cell Type of Part Number 1 changed to %s.\n',app.CellTypeP1.Value);
            end
            app.showParts(app.CurrentLayer);
        end

        % Value changed function: CellTypeP2
        function CellTypeP2ValueChanged(app, event)
            app.CurrentPartNum = 2; Edited = false;
            fprintf('USER: Change the Cell Type of Part 2 to %s.\n',app.CellTypeP2.Value);

            switch app.CellTypeP2.Value
                case "Choose Cell Type"
                    % Remove Parts 2, 3 and 4.
                    while app.NumParts > 1
                        app.CurrentLayer.removePart(app.NumParts);
                        app.NumParts = app.CurrentLayer.Length;
                    end
                    app.CellTypeP3.Enable = 'off';
                    app.CellTypeP4.Enable = 'off';
                    app.Edit_P2.Enable = 'off';
                    app.Edit_P3.Enable = 'off';
                    app.Edit_P4.Enable = 'off';
                    app.SurfaceRatioP2.Enable = 'off';
                    app.SurfaceRatioP3.Enable = 'off';
                    app.SurfaceRatioP4.Enable = 'off';
                    Edited = false;
                case "Strut"
                    app.createPart("Strut");
                    app.Edit_P2.Enable = 'on';
                    app.SurfaceRatioP2.Enable = 'on';
                    app.CellTypeP3.Enable = 'on';
                    Edited = true;
                case "Plate"
                    app.createPart("Plate");
                    app.Edit_P2.Enable = 'on';
                    app.SurfaceRatioP2.Enable = 'on';
                    app.CellTypeP3.Enable = 'on';
                    Edited = true;
                case "TPMS"
                    app.createPart("TPMS");
                    app.Edit_P2.Enable = 'on';
                    app.SurfaceRatioP2.Enable = 'on';
                    app.CellTypeP3.Enable = 'on';
                    Edited = true;
            end

            if Edited == true
                if app.CurrentPartNum <= app.NumParts
                    app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
                    app.updatePart(app.CurrentPart);
                else
                    app.CurrentLayer.insertPart(app.CurrentPart,1/2);
                    app.NumParts = app.CurrentLayer.Length;
                end
                fprintf('Cell Type of Part Number 2 changed to %s.\n',app.CellTypeP2.Value);
            end
            app.showParts(app.CurrentLayer);
        end

        % Value changed function: CellTypeP3
        function CellTypeP3ValueChanged(app, event)
            app.CurrentPartNum = 3; Edited = false;
            fprintf('USER: Change the Cell Type of Part 3 to %s.\n',app.CellTypeP3.Value);

            switch app.CellTypeP3.Value
                case "Choose Cell Type"
                    % Remove Parts 3 and 4.
                    while app.NumParts > 2
                        app.CurrentLayer.removePart(app.NumParts);
                        app.NumParts = app.CurrentLayer.Length;
                    end
                    app.CellTypeP4.Enable = 'off';
                    app.Edit_P3.Enable = 'off';
                    app.Edit_P4.Enable = 'off';
                    app.SurfaceRatioP3.Enable = 'off';
                    app.SurfaceRatioP4.Enable = 'off';
                    Edited = false;
                case "Strut"
                    app.createPart("Strut");
                    app.Edit_P3.Enable = 'on';
                    app.SurfaceRatioP3.Enable = 'on';
                    app.CellTypeP4.Enable = 'on';
                    Edited = true;
                case "Plate"
                    app.createPart("Plate");
                    app.Edit_P3.Enable = 'on';
                    app.SurfaceRatioP3.Enable = 'on';
                    app.CellTypeP4.Enable = 'on';
                    Edited = true;
                case "TPMS"
                    app.createPart("TPMS");
                    app.Edit_P3.Enable = 'on';
                    app.SurfaceRatioP3.Enable = 'on';
                    app.CellTypeP4.Enable = 'on';
                    Edited = true;
            end

            if Edited == true
                if app.CurrentPartNum <= app.NumParts
                    app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
                    app.updatePart(app.CurrentPart);
                else
                    app.CurrentLayer.insertPart(app.CurrentPart,1/2);
                    app.NumParts = app.CurrentLayer.Length;
                end
                fprintf('Cell Type of Part Number 3 changed to %s.\n',app.CellTypeP3.Value);
            end
            app.showParts(app.CurrentLayer);
        end

        % Value changed function: CellTypeP4
        function CellTypeP4ValueChanged(app, event)
            app.CurrentPartNum = 4; Edited = false;
            fprintf('USER: Change the Cell Type of Part 4 to %s.\n',app.CellTypeP4.Value);

            switch app.CellTypeP4.Value
                case "Choose Cell Type"
                    % Remove Part 4.
                    while app.NumParts > 3
                        app.CurrentLayer.removePart(app.NumParts);
                        app.NumParts = app.CurrentLayer.Length;
                    end
                    app.Edit_P4.Enable = 'off';
                    app.SurfaceRatioP4.Enable = 'off';
                    Edited = false;
                case "Strut"
                    app.createPart("Strut");
                    app.Edit_P4.Enable = 'on';
                    app.SurfaceRatioP4.Enable = 'on';
                    Edited = true;
                case "Plate"
                    app.createPart("Plate");
                    app.Edit_P4.Enable = 'on';
                    app.SurfaceRatioP4.Enable = 'on';
                    Edited = true;
                case "TPMS"
                    app.createPart("TPMS");
                    app.Edit_P4.Enable = 'on';
                    app.SurfaceRatioP4.Enable = 'on';
                    Edited = true;
            end

            if Edited == true
                if app.CurrentPartNum <= app.NumParts
                    app.CurrentPartNode = app.CurrentLayer.getNode(app.CurrentPartNum);
                    app.updatePart(app.CurrentPart);
                else
                    app.CurrentLayer.insertPart(app.CurrentPart,1/2);
                    app.NumParts = app.CurrentLayer.Length;
                end
                fprintf('Cell Type of Part Number 4 changed to %s.\n',app.CellTypeP1.Value);
            end
            app.showParts(app.CurrentLayer);
        end

        % Button pushed function: Edit_P1
        function Edit_P1ButtonPushed(app, event)
            fprintf('USER: Editing Layer Part 1.\n');
            app.editPart(1,app.CellTypeP1.Value);
        end

        % Button pushed function: Edit_P2
        function Edit_P2ButtonPushed(app, event)
            fprintf('USER: Editing Layer Part 2.\n');
            app.editPart(2,app.CellTypeP2.Value);
        end

        % Button pushed function: Edit_P3
        function Edit_P3ButtonPushed(app, event)
            fprintf('USER: Editing Layer Part 3.\n');
            app.editPart(3,app.CellTypeP3.Value);
        end

        % Button pushed function: Edit_P4
        function Edit_P4ButtonPushed(app, event)
            fprintf('USER: Editing Layer Part 4.\n');
            app.editPart(4,app.CellTypeP4.Value);
        end

        % Value changed function: SurfaceRatioP1
        function SurfaceRatioP1ValueChanged(app, event)
            fprintf('USER: Change the Surface Ratio of Part 1 to %d.\n',app.SurfaceRatioP1.Value);
            if app.SurfaceRatioP1.Value > 0
                app.editPartSR(1,app.SurfaceRatioP1.Value);
            else
                app.CurrentPartNode = app.CurrentLayer.getNode(1);
                app.CurrentPart = app.CurrentPartNode.Data;
                app.SurfaceRatioP1.Value = app.CurrentPart.SurfaceRatio;
            end
        end

        % Value changed function: SurfaceRatioP2
        function SurfaceRatioP2ValueChanged(app, event)
            fprintf('USER: Change the Surface Ratio of Part 2 to %d.\n',app.SurfaceRatioP2.Value);
            if app.SurfaceRatioP2.Value > 0
                app.editPartSR(2,app.SurfaceRatioP2.Value);
            else
                app.CurrentPartNode = app.CurrentLayer.getNode(2);
                app.CurrentPart = app.CurrentPartNode.Data;
                app.SurfaceRatioP2.Value = app.CurrentPart.SurfaceRatio;
            end
        end

        % Value changed function: SurfaceRatioP3
        function SurfaceRatioP3ValueChanged(app, event)
            fprintf('USER: Change the Surface Ratio of Part 3 to %d.\n',app.SurfaceRatioP3.Value);
            if app.SurfaceRatioP3.Value > 0
                app.editPartSR(3,app.SurfaceRatioP3.Value);
            else
                app.CurrentPartNode = app.CurrentLayer.getNode(3);
                app.CurrentPart = app.CurrentPartNode.Data;
                app.SurfaceRatioP3.Value = app.CurrentPart.SurfaceRatio;
            end
        end

        % Value changed function: SurfaceRatioP4
        function SurfaceRatioP4ValueChanged(app, event)
            fprintf('USER: Change the Surface Ratio of Part 4 to %d.\n',app.SurfaceRatioP4.Value);
            if app.SurfaceRatioP4.Value > 0
                app.editPartSR(4,app.SurfaceRatioP4.Value);
            else
                app.CurrentPartNode = app.CurrentLayer.getNode(4);
                app.CurrentPart = app.CurrentPartNode.Data;
                app.SurfaceRatioP4.Value = app.CurrentPart.SurfaceRatio;
            end
        end

        % Button pushed function: PlotSoundAbsorptionButton
        function PlotSoundAbsorptionButtonPushed(app, event)
            fprintf('USER: Plot the Sound Absorption Coefficient.\n');
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Calculating Sound Absorption Coefficients',...
                'Indeterminate','on');

            % Refresh all properties on UI and main app.
            app.updateLattice();

            app.LatticeStructure.calcTMM();
            app.LatticeStructure.calcSAC();
            app.plotSAC();
            
            app.TabGroup.SelectedTab = app.LatticeSACPlotsandDataTab;
            delete(fig);
        end

        % Button pushed function: BackButton
        function BackButtonPushed(app, event)
            fprintf('USER: Back to editing Lattice Structure.\n');
            app.TabGroup.SelectedTab = app.LatticePropertiesTab;
        end

        % Button pushed function: SaveLatticeDesignButton
        function SaveLatticeDesignButtonPushed(app, event)
            fprintf('USER: Save Current Lattice to Library.\n');
            app.SaveLattApp = SaveLatt(app,"LatticeStructure");
            fprintf('Lattice Saved to Library.\n');
        end

        % Button pushed function: ExportLatticeDesignButton
        function ExportLatticeDesignButtonPushed(app, event)
            fprintf('USER: Export the Lattice Design.\n');
            app.ExportLattApp = ExportLatt(app,app.LatticeStructure);
        end

        % Button pushed function: SaveSACPlotandDataButton
        function SaveSACPlotandDataButtonPushed(app, event)
            fprintf('USER: Save the SAC Plot and Data.\n');
            app.SaveSACApp = SaveSAC(app,app.LatticeStructure);
        end

        % Button pushed function: RefreshButton
        function RefreshButtonPushed(app, event)
            fprintf('USER: Refresh Button pressed.\n');
            % Refresh all properties on UI and main app.
            app.updateLattice();
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            fprintf('USER: Reset Button pressed.\n');
            app.resetApp();
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            fprintf('USER: Application closed.\n');
            delete(app.LattLayerPartProp);
            delete(app.LoadLattApp);
            delete(app.SaveLattApp);
            delete(app.ExportLattApp);
            delete(app.SaveSACApp);
            delete(app);
        end

        % Value changed function: CrossSectionFLDropDown
        function CrossSectionFLDropDownValueChanged(app, event)
            app.CrossSection_FL = app.CrossSectionFLDropDown.Value;
            fprintf('USER: Lattice (FL) Cross Section changed to %s.\n',app.CrossSection_FL);
        end

        % Value changed function: LengthDiametermmFLSlider
        function LengthDiametermmFLSliderValueChanged(app, event)
            app.SampleLength_FL = app.LengthDiametermmFLSlider.Value;
            app.SampleDiameter_FL = app.LengthDiametermmFLSlider.Value;
            app.LengthDiametermmFLSliderNumeric.Value = app.LengthDiametermmFLSlider.Value;
            
            fprintf('USER: Lattice (FL) Length or Diameter changed to %d.\n',app.SampleLength_FL);
        end

        % Value changed function: LengthDiametermmFLSliderNumeric
        function LengthDiametermmFLSliderNumericValueChanged(app, event)
            value = app.LengthDiametermmFLSliderNumeric.Value;
            
            app.SampleLength_FL = app.LengthDiametermmFLSliderNumeric.Value;
            app.SampleDiameter_FL = app.LengthDiametermmFLSliderNumeric.Value;

            app.LengthDiametermmFLSlider.Value = value;

            fprintf('USER: Lattice (FL) Length or Diameter changed to %d.\n',app.SampleLength_FL);
        end

        % Value changed function: NumberofLayersSpinnerFL
        function NumberofLayersSpinnerFLValueChanged(app, event)
            app.NumLayers_FL = app.NumberofLayersSpinnerFL.Value;
            fprintf('USER: Change Number of Layers to %d.\n',app.NumLayers_FL);
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Changing Number of Layers','Indeterminate','on');

            % Add or remove Lattice Layers from the BoundsList.
            if app.BoundsList.Length < app.NumLayers_FL
                % Add layers
                while app.BoundsList.Length < app.NumLayers_FL
                    app.createBounds("Strut");
                    app.BoundsList.insert(app.CurrentLayerBounds_FL,app.BoundsList.Length+1);
                end
            else
                % Remove layers
                while app.BoundsList.Length > app.NumLayers_FL
                    app.BoundsList.remove(app.BoundsList.Length);
                end
            end

            app.loadBounds(app.BoundsList);
            fprintf('Number of Lattice Layers (FL) changed to %d.\n',app.NumLayers_FL);
            delete(fig);
        end

        % Value changing function: NumberofLayersSpinnerFL
        function NumberofLayersSpinnerFLValueChanging(app, event)
            app.NumLayers_FL = event.Value;
            fprintf('USER: Change Number of Layers to %d.\n',app.NumLayers_FL);
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Changing Number of Layers','Indeterminate','on');

            % Add or remove Lattice Layers from the BoundsList.
            if app.BoundsList.Length < app.NumLayers_FL
                % Add layers
                while app.BoundsList.Length < app.NumLayers_FL
                    app.createBounds("Strut");
                    app.BoundsList.insert(app.CurrentLayerBounds_FL,app.BoundsList.Length+1);
                end
            else
                % Remove layers
                while app.BoundsList.Length > app.NumLayers_FL
                    app.BoundsList.remove(app.BoundsList.Length);
                end
            end

            app.loadBounds(app.BoundsList);
            fprintf('Number of Lattice Layers (FL) changed to %d.\n',app.NumLayers_FL);
            delete(fig);
        end

        % Value changed function: FreqLowerBoundSpinnerFL
        function FreqLowerBoundSpinnerFLValueChanged(app, event)
            value = app.FreqLowerBoundSpinnerFL.Value;
            fprintf('USER: Change Frequency Range (FL) to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);

            if app.FreqUpperBoundSpinnerFL.Value < value + 100
                app.FreqUpperBoundSpinnerFL.Value = ...
                    min([changingValue + 100,app.FreqUpperBoundSpinnerFL.Limits(2)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;
            fprintf('Frequency Range (FL) changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);
        end

        % Value changed function: FreqUpperBoundSpinnerFL
        function FreqUpperBoundSpinnerFLValueChanged(app, event)
            value = app.FreqUpperBoundSpinnerFL.Value;
            fprintf('USER: Change Frequency Range (FL) to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);

            if app.FreqLowerBoundSpinnerFL.Value > value - 100
                app.FreqLowerBoundSpinnerFL.Value = ...
                    max([changingValue - 100,app.FreqLowerBoundSpinnerFL.Limits(1)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;
            fprintf('Frequency Range (FL) changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);
        end

        % Value changing function: FreqLowerBoundSpinnerFL
        function FreqLowerBoundSpinnerFLValueChanging(app, event)
            changingValue = event.Value;
            fprintf('USER: Change Frequency Range (FL) to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);

            if app.FreqUpperBoundSpinnerFL.Value < changingValue + 100
                app.FreqUpperBoundSpinnerFL.Value = ...
                    min([changingValue + 100,app.FreqUpperBoundSpinnerFL.Limits(2)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;
            fprintf('Frequency Range (FL) changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);
        end

        % Value changing function: FreqUpperBoundSpinnerFL
        function FreqUpperBoundSpinnerFLValueChanging(app, event)
            changingValue = event.Value;
            fprintf('USER: Change Frequency Range (FL) to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);

            if app.FreqLowerBoundSpinnerFL.Value > changingValue - 100
                app.FreqLowerBoundSpinnerFL.Value = ...
                    max([changingValue - 100,app.FreqLowerBoundSpinnerFL.Limits(1)]);
            end
            app.Frequency = ...
                app.FreqLowerBoundSpinnerFL.Value:10:app.FreqUpperBoundSpinnerFL.Value;
            fprintf('Frequency Range (FL) changed to %d Hz to %d Hz.\n', ...
                app.FreqLowerBoundSpinnerFL.Value,app.FreqUpperBoundSpinnerFL.Value);
        end

        % Value changed function: ThicknessmmEditFieldFL
        function ThicknessmmEditFieldFLValueChanged(app, event)
            app.Thickness_FL = app.ThicknessmmEditFieldFL.Value;
            fprintf('USER: Maximum Thickness (FL) changed to %d mm.\n', ...
                app.Thickness_FL);
        end

        % Value changed function: NumberofIterationsFLSpinner
        function NumberofIterationsFLSpinnerValueChanged(app, event)
            app.Iteration_FL = app.NumberofIterationsFLSpinner.Value;
            fprintf('USER: Maximum Iterations (FL) changed to %d.\n', ...
                app.Iteration_FL);
        end

        % Value changing function: NumberofIterationsFLSpinner
        function NumberofIterationsFLSpinnerValueChanging(app, event)
            app.Iteration_FL = event.Value;
            fprintf('USER: Maximum Iterations (FL) changed to %d.\n', ...
                app.Iteration_FL);
        end

        % Value changed function: LayerNumberFLDropDown
        function LayerNumberFLDropDownValueChanged(app, event)
            value = app.LayerNumberFLDropDown.Value;
            fprintf('USER: Change Layer Number (FL) to %s.\n',value);

            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Loading Layer Information','Indeterminate','on');

            app.CurrentLayerNum_FL = str2double(value);
            app.CurrentLayerNode_FL = app.BoundsList.getNode(app.CurrentLayerNum_FL);
            app.CurrentLayerBounds_FL = app.CurrentLayerNode_FL.Data;
            
            % Update Part Information
            app.showBounds(app.CurrentLayerBounds_FL);
            fprintf('Current Layer changed to %d.\n',app.CurrentLayerNum_FL);
            delete(fig);
        end

        % Value changed function: CellTypeFL
        function CellTypeFLValueChanged(app, event)
            Edited = false;
            fprintf('USER: Change the Cell Type of Layer %d to %s.\n', ...
                app.CurrentLayerNum_FL,app.CellTypeFL.Value);

            switch app.CellTypeFL.Value
                case "Strut"
                    app.createBounds("Strut");
                    app.Edit_FL.Enable = 'on';
                    Edited = true;
                case "Plate"
                    app.createBounds("Plate");
                    app.Edit_FL.Enable = 'on';
                    Edited = true;
                case "TPMS"
                    app.createBounds("TPMS");
                    app.Edit_FL.Enable = 'on';
                    Edited = true;
            end

            if Edited == true
                if app.CurrentLayerNum_FL <= app.BoundsList.Length()
                    app.updateBounds(app.CurrentLayerBounds_FL);
                else
                    app.BoundsList.insert(app.CurrentLayerBounds_FL,app.CurrentLayerNum_FL);
                end
                fprintf('Cell Type of Layer Number %d changed to %s.\n',...
                    app.CurrentLayerNum_FL,app.CellTypeP1.Value);
            end
            app.showBounds(app.CurrentLayerBounds_FL);
        end

        % Button pushed function: Edit_FL
        function Edit_FLButtonPushed(app, event)
            fprintf('USER: Editing Layer Bounds.\n');
            app.editBounds(app.CellTypeFL.Value);
        end

        % Clicked callback: UITable
        function UITableClicked(app, event)
            displayRow = event.InteractionInformation.DisplayRow;
            if displayRow <= app.FindLatticeResults.Length
                node = app.FindLatticeResults.getNode(displayRow);
                app.SelectedLattice_FL = node.Data;
            end
        end

        % Button pushed function: FindLatticeButton
        function FindLatticeButtonPushed(app, event)
            fprintf('USER: Find Lattice Button pressed.\n');
            app.compileConstraints();
            if app.MinThickness_FL <= app.Thickness_FL
                app.findLattice();
            else
                fig = uifigure('Position',[250 400 340 170]);
                message = ["Minimum permissible thickness exceeds","maximum allowable thickness."];
                uialert(fig,message,"No Solutions Found.", ...
                    "Icon","error");
            end
        end

        % Button pushed function: PlotSACButtonFindLattice
        function PlotSACButtonFindLatticePushed(app, event)
            fprintf('USER: Plot the Sound Absorption Coefficient.\n');
            fig = uifigure('Position',[250 400 400 110]);
            uiprogressdlg(fig,'Title','Please Wait',...
                'Message','Calculating Sound Absorption Coefficients',...
                'Indeterminate','on');

            % Refresh all properties on UI and main app.
            if ~isempty(app.SelectedLattice_FL)
                % Update the LatticeStructure in the main app.
                app.loadLatt(app.SelectedLattice_FL);
            end
            app.LatticeStructure.calcTMM();
            app.LatticeStructure.calcSAC();
            app.plotSAC();
            
            app.TabGroup.SelectedTab = app.LatticeSACPlotsandDataTab;
            delete(fig);
        end

        % Button pushed function: SaveResultsButton
        function SaveResultsButtonPushed(app, event)
            fprintf('USER: Save Results Button pressed.\n');
            app.SaveLattApp = SaveLatt(app,"LatticeLibrary");
        end

        % Button pushed function: ClearResultsButton
        function ClearResultsButtonPushed(app, event)
            fprintf('USER: Clear Results Button pressed.\n');
            
            app.FindLatticeResults = LatticeLib();
            app.showResultsTable();
        end

        % Button pushed function: ResetFindLattice
        function ResetFindLatticeButtonPushed(app, event)
            fprintf('USER: Reset Button pressed.\n');
            app.resetApp();
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
            app.UIFigure.Position = [100 100 700 700];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create ZhaiGroupLogo
            app.ZhaiGroupLogo = uiimage(app.UIFigure);
            app.ZhaiGroupLogo.Position = [1 620 160 80];
            app.ZhaiGroupLogo.ImageSource = fullfile(pathToMLAPP, 'NUS Zhai Group Logo.png');

            % Create AppTitle
            app.AppTitle = uilabel(app.UIFigure);
            app.AppTitle.HorizontalAlignment = 'center';
            app.AppTitle.FontSize = 24;
            app.AppTitle.FontWeight = 'bold';
            app.AppTitle.Position = [275 670 150 30];
            app.AppTitle.Text = 'LattSAC';

            % Create NUSLogo
            app.NUSLogo = uiimage(app.UIFigure);
            app.NUSLogo.Position = [540 620 160 80];
            app.NUSLogo.ImageSource = fullfile(pathToMLAPP, 'NUS Logo.png');

            % Create DesignyourownLatticeSoundAbsorberLabel
            app.DesignyourownLatticeSoundAbsorberLabel = uilabel(app.UIFigure);
            app.DesignyourownLatticeSoundAbsorberLabel.HorizontalAlignment = 'center';
            app.DesignyourownLatticeSoundAbsorberLabel.VerticalAlignment = 'top';
            app.DesignyourownLatticeSoundAbsorberLabel.FontSize = 18;
            app.DesignyourownLatticeSoundAbsorberLabel.Position = [160 640 380 30];
            app.DesignyourownLatticeSoundAbsorberLabel.Text = 'Design your own Lattice Sound Absorber';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [5 25 690 595];

            % Create LatticePropertiesTab
            app.LatticePropertiesTab = uitab(app.TabGroup);
            app.LatticePropertiesTab.Title = 'Lattice Properties';
            app.LatticePropertiesTab.BackgroundColor = [1 1 1];

            % Create Panel
            app.Panel = uipanel(app.LatticePropertiesTab);
            app.Panel.BorderColor = [0 0 0];
            app.Panel.BorderWidth = 2;
            app.Panel.BackgroundColor = [1 1 1];
            app.Panel.Position = [5 475 680 90];

            % Create CrossSectionDropDownLabel
            app.CrossSectionDropDownLabel = uilabel(app.Panel);
            app.CrossSectionDropDownLabel.FontSize = 16;
            app.CrossSectionDropDownLabel.Position = [5 60 105 22];
            app.CrossSectionDropDownLabel.Text = 'Cross Section';

            % Create CrossSectionDropDown
            app.CrossSectionDropDown = uidropdown(app.Panel);
            app.CrossSectionDropDown.Items = {'Circular', 'Square'};
            app.CrossSectionDropDown.ValueChangedFcn = createCallbackFcn(app, @CrossSectionDropDownValueChanged, true);
            app.CrossSectionDropDown.FontSize = 16;
            app.CrossSectionDropDown.Position = [145 60 150 22];
            app.CrossSectionDropDown.Value = 'Circular';

            % Create LengthDiametermmSliderLabel
            app.LengthDiametermmSliderLabel = uilabel(app.Panel);
            app.LengthDiametermmSliderLabel.WordWrap = 'on';
            app.LengthDiametermmSliderLabel.FontSize = 16;
            app.LengthDiametermmSliderLabel.Position = [310 36 119 48];
            app.LengthDiametermmSliderLabel.Text = 'Length/Diameter (mm)';

            % Create LengthDiametermmSlider
            app.LengthDiametermmSlider = uislider(app.Panel);
            app.LengthDiametermmSlider.Limits = [10 50];
            app.LengthDiametermmSlider.MajorTicks = [10 20 30 40 50];
            app.LengthDiametermmSlider.ValueChangedFcn = createCallbackFcn(app, @LengthDiametermmSliderValueChanged, true);
            app.LengthDiametermmSlider.FontSize = 16;
            app.LengthDiametermmSlider.Position = [460 72 140 3];
            app.LengthDiametermmSlider.Value = 30;

            % Create LengthDiametermmSliderNumeric
            app.LengthDiametermmSliderNumeric = uieditfield(app.Panel, 'numeric');
            app.LengthDiametermmSliderNumeric.HorizontalAlignment = 'center';
            app.LengthDiametermmSliderNumeric.FontSize = 16;
            app.LengthDiametermmSliderNumeric.Position = [610 62 60 22];
            app.LengthDiametermmSliderNumeric.Value = 30;

            % Create ThicknessmmEditFieldLabel
            app.ThicknessmmEditFieldLabel = uilabel(app.Panel);
            app.ThicknessmmEditFieldLabel.FontSize = 16;
            app.ThicknessmmEditFieldLabel.Position = [6 33 119 22];
            app.ThicknessmmEditFieldLabel.Text = 'Thickness (mm)';

            % Create ThicknessmmEditField
            app.ThicknessmmEditField = uieditfield(app.Panel, 'numeric');
            app.ThicknessmmEditField.Editable = 'off';
            app.ThicknessmmEditField.HorizontalAlignment = 'center';
            app.ThicknessmmEditField.FontSize = 16;
            app.ThicknessmmEditField.Position = [145 33 150 22];
            app.ThicknessmmEditField.Value = 24;

            % Create NumberofLayersSpinnerLabel
            app.NumberofLayersSpinnerLabel = uilabel(app.Panel);
            app.NumberofLayersSpinnerLabel.FontSize = 16;
            app.NumberofLayersSpinnerLabel.Position = [5 5 140 22];
            app.NumberofLayersSpinnerLabel.Text = 'Number of Layers';

            % Create NumberofLayersSpinner
            app.NumberofLayersSpinner = uispinner(app.Panel);
            app.NumberofLayersSpinner.ValueChangingFcn = createCallbackFcn(app, @NumberofLayersSpinnerValueChanging, true);
            app.NumberofLayersSpinner.Limits = [1 6];
            app.NumberofLayersSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofLayersSpinnerValueChanged, true);
            app.NumberofLayersSpinner.HorizontalAlignment = 'center';
            app.NumberofLayersSpinner.FontSize = 16;
            app.NumberofLayersSpinner.Position = [145 5 150 22];
            app.NumberofLayersSpinner.Value = 1;

            % Create FreqLabel_1
            app.FreqLabel_1 = uilabel(app.Panel);
            app.FreqLabel_1.FontSize = 16;
            app.FreqLabel_1.Position = [310 5 81 22];
            app.FreqLabel_1.Text = 'Frequency';

            % Create FreqLowerBoundSpinner
            app.FreqLowerBoundSpinner = uispinner(app.Panel);
            app.FreqLowerBoundSpinner.Step = 50;
            app.FreqLowerBoundSpinner.ValueChangingFcn = createCallbackFcn(app, @FreqLowerBoundSpinnerValueChanging, true);
            app.FreqLowerBoundSpinner.Limits = [500 6300];
            app.FreqLowerBoundSpinner.ValueChangedFcn = createCallbackFcn(app, @FreqLowerBoundSpinnerValueChanged, true);
            app.FreqLowerBoundSpinner.HorizontalAlignment = 'center';
            app.FreqLowerBoundSpinner.FontSize = 16;
            app.FreqLowerBoundSpinner.Position = [460 5 75 22];
            app.FreqLowerBoundSpinner.Value = 1000;

            % Create FreqLabel_2
            app.FreqLabel_2 = uilabel(app.Panel);
            app.FreqLabel_2.FontSize = 16;
            app.FreqLabel_2.Position = [535 5 40 22];
            app.FreqLabel_2.Text = 'Hz to';

            % Create FreqUpperBoundSpinner
            app.FreqUpperBoundSpinner = uispinner(app.Panel);
            app.FreqUpperBoundSpinner.Step = 50;
            app.FreqUpperBoundSpinner.ValueChangingFcn = createCallbackFcn(app, @FreqUpperBoundSpinnerValueChanging, true);
            app.FreqUpperBoundSpinner.Limits = [500 6300];
            app.FreqUpperBoundSpinner.ValueChangedFcn = createCallbackFcn(app, @FreqUpperBoundSpinnerValueChanged, true);
            app.FreqUpperBoundSpinner.Tag = 'Frequency_end';
            app.FreqUpperBoundSpinner.HorizontalAlignment = 'center';
            app.FreqUpperBoundSpinner.FontSize = 16;
            app.FreqUpperBoundSpinner.Position = [575 5 75 22];
            app.FreqUpperBoundSpinner.Value = 6300;

            % Create FreqLabel_3
            app.FreqLabel_3 = uilabel(app.Panel);
            app.FreqLabel_3.FontSize = 16;
            app.FreqLabel_3.Position = [650 5 20 22];
            app.FreqLabel_3.Text = 'Hz';

            % Create Panel_2
            app.Panel_2 = uipanel(app.LatticePropertiesTab);
            app.Panel_2.BorderColor = [0 0 0];
            app.Panel_2.BorderWidth = 2;
            app.Panel_2.BackgroundColor = [1 1 1];
            app.Panel_2.Position = [5 50 680 420];

            % Create GridLayout
            app.GridLayout = uigridlayout(app.Panel_2);
            app.GridLayout.ColumnWidth = {'0.7x', '1x', 'fit', '0.7x', '1x', 'fit', '0.7x', '1x', 'fit', '0.7x', '1x', 'fit'};
            app.GridLayout.RowHeight = {'fit', 'fit', 'fit', 'fit', '1x'};
            app.GridLayout.ColumnSpacing = 5;
            app.GridLayout.RowSpacing = 2;
            app.GridLayout.Padding = [5 5 5 5];
            app.GridLayout.BackgroundColor = [1 1 1];

            % Create Part1Label
            app.Part1Label = uilabel(app.GridLayout);
            app.Part1Label.HorizontalAlignment = 'center';
            app.Part1Label.FontSize = 14;
            app.Part1Label.Layout.Row = 2;
            app.Part1Label.Layout.Column = [1 3];
            app.Part1Label.Text = 'Part 1';

            % Create Part2Label
            app.Part2Label = uilabel(app.GridLayout);
            app.Part2Label.HorizontalAlignment = 'center';
            app.Part2Label.FontSize = 14;
            app.Part2Label.Layout.Row = 2;
            app.Part2Label.Layout.Column = [4 6];
            app.Part2Label.Text = 'Part 2';

            % Create Part3Label
            app.Part3Label = uilabel(app.GridLayout);
            app.Part3Label.HorizontalAlignment = 'center';
            app.Part3Label.FontSize = 14;
            app.Part3Label.Layout.Row = 2;
            app.Part3Label.Layout.Column = [7 9];
            app.Part3Label.Text = 'Part 3';

            % Create Part4Label
            app.Part4Label = uilabel(app.GridLayout);
            app.Part4Label.HorizontalAlignment = 'center';
            app.Part4Label.FontSize = 14;
            app.Part4Label.Layout.Row = 2;
            app.Part4Label.Layout.Column = [10 12];
            app.Part4Label.Text = 'Part 4';

            % Create CellTypeP1
            app.CellTypeP1 = uidropdown(app.GridLayout);
            app.CellTypeP1.Items = {'Cell Type', 'Strut', 'Plate', 'TPMS', 'None'};
            app.CellTypeP1.ValueChangedFcn = createCallbackFcn(app, @CellTypeP1ValueChanged, true);
            app.CellTypeP1.Tag = 'CellLayer1Part1';
            app.CellTypeP1.Layout.Row = 3;
            app.CellTypeP1.Layout.Column = [1 2];
            app.CellTypeP1.Value = 'Cell Type';

            % Create CellTypeP2
            app.CellTypeP2 = uidropdown(app.GridLayout);
            app.CellTypeP2.Items = {'Cell Type', 'Strut', 'Plate', 'TPMS'};
            app.CellTypeP2.ValueChangedFcn = createCallbackFcn(app, @CellTypeP2ValueChanged, true);
            app.CellTypeP2.Layout.Row = 3;
            app.CellTypeP2.Layout.Column = [4 5];
            app.CellTypeP2.Value = 'Cell Type';

            % Create CellTypeP3
            app.CellTypeP3 = uidropdown(app.GridLayout);
            app.CellTypeP3.Items = {'Cell Type', 'Strut', 'Plate', 'TPMS'};
            app.CellTypeP3.ValueChangedFcn = createCallbackFcn(app, @CellTypeP3ValueChanged, true);
            app.CellTypeP3.Layout.Row = 3;
            app.CellTypeP3.Layout.Column = [7 8];
            app.CellTypeP3.Value = 'Cell Type';

            % Create CellTypeP4
            app.CellTypeP4 = uidropdown(app.GridLayout);
            app.CellTypeP4.Items = {'Cell Type', 'Strut', 'Plate', 'TPMS'};
            app.CellTypeP4.ValueChangedFcn = createCallbackFcn(app, @CellTypeP4ValueChanged, true);
            app.CellTypeP4.Layout.Row = 3;
            app.CellTypeP4.Layout.Column = [10 11];
            app.CellTypeP4.Value = 'Cell Type';

            % Create Edit_P1
            app.Edit_P1 = uibutton(app.GridLayout, 'push');
            app.Edit_P1.ButtonPushedFcn = createCallbackFcn(app, @Edit_P1ButtonPushed, true);
            app.Edit_P1.Layout.Row = 3;
            app.Edit_P1.Layout.Column = 3;
            app.Edit_P1.Text = 'Edit';

            % Create Edit_P2
            app.Edit_P2 = uibutton(app.GridLayout, 'push');
            app.Edit_P2.ButtonPushedFcn = createCallbackFcn(app, @Edit_P2ButtonPushed, true);
            app.Edit_P2.Layout.Row = 3;
            app.Edit_P2.Layout.Column = 6;
            app.Edit_P2.Text = 'Edit';

            % Create Edit_P3
            app.Edit_P3 = uibutton(app.GridLayout, 'push');
            app.Edit_P3.ButtonPushedFcn = createCallbackFcn(app, @Edit_P3ButtonPushed, true);
            app.Edit_P3.Layout.Row = 3;
            app.Edit_P3.Layout.Column = 9;
            app.Edit_P3.Text = 'Edit';

            % Create Edit_P4
            app.Edit_P4 = uibutton(app.GridLayout, 'push');
            app.Edit_P4.ButtonPushedFcn = createCallbackFcn(app, @Edit_P4ButtonPushed, true);
            app.Edit_P4.Layout.Row = 3;
            app.Edit_P4.Layout.Column = 12;
            app.Edit_P4.Text = 'Edit';

            % Create SurfaceRatioP1
            app.SurfaceRatioP1 = uislider(app.GridLayout);
            app.SurfaceRatioP1.Limits = [0 1];
            app.SurfaceRatioP1.MajorTicks = [0 0.2 0.4 0.6 0.8 1];
            app.SurfaceRatioP1.ValueChangedFcn = createCallbackFcn(app, @SurfaceRatioP1ValueChanged, true);
            app.SurfaceRatioP1.MinorTicks = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
            app.SurfaceRatioP1.Layout.Row = 4;
            app.SurfaceRatioP1.Layout.Column = [2 3];

            % Create SurfaceRatioP2
            app.SurfaceRatioP2 = uislider(app.GridLayout);
            app.SurfaceRatioP2.Limits = [0 1];
            app.SurfaceRatioP2.MajorTicks = [0 0.2 0.4 0.6 0.8 1];
            app.SurfaceRatioP2.ValueChangedFcn = createCallbackFcn(app, @SurfaceRatioP2ValueChanged, true);
            app.SurfaceRatioP2.MinorTicks = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
            app.SurfaceRatioP2.Layout.Row = 4;
            app.SurfaceRatioP2.Layout.Column = [5 6];

            % Create SurfaceRatioP3
            app.SurfaceRatioP3 = uislider(app.GridLayout);
            app.SurfaceRatioP3.Limits = [0 1];
            app.SurfaceRatioP3.MajorTicks = [0 0.2 0.4 0.6 0.8 1];
            app.SurfaceRatioP3.ValueChangedFcn = createCallbackFcn(app, @SurfaceRatioP3ValueChanged, true);
            app.SurfaceRatioP3.MinorTicks = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
            app.SurfaceRatioP3.Layout.Row = 4;
            app.SurfaceRatioP3.Layout.Column = [8 9];

            % Create SurfaceRatioP4
            app.SurfaceRatioP4 = uislider(app.GridLayout);
            app.SurfaceRatioP4.Limits = [0 1];
            app.SurfaceRatioP4.MajorTicks = [0 0.2 0.4 0.6 0.8 1];
            app.SurfaceRatioP4.ValueChangedFcn = createCallbackFcn(app, @SurfaceRatioP4ValueChanged, true);
            app.SurfaceRatioP4.MinorTicks = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
            app.SurfaceRatioP4.Layout.Row = 4;
            app.SurfaceRatioP4.Layout.Column = [11 12];

            % Create TextAreaP1
            app.TextAreaP1 = uitextarea(app.GridLayout);
            app.TextAreaP1.Editable = 'off';
            app.TextAreaP1.Layout.Row = 5;
            app.TextAreaP1.Layout.Column = [1 3];

            % Create LayerNumberDropDownLabel
            app.LayerNumberDropDownLabel = uilabel(app.GridLayout);
            app.LayerNumberDropDownLabel.FontSize = 16;
            app.LayerNumberDropDownLabel.Layout.Row = 1;
            app.LayerNumberDropDownLabel.Layout.Column = [1 2];
            app.LayerNumberDropDownLabel.Text = 'Layer Number';

            % Create SurfaceRatioSliderLabel
            app.SurfaceRatioSliderLabel = uilabel(app.GridLayout);
            app.SurfaceRatioSliderLabel.WordWrap = 'on';
            app.SurfaceRatioSliderLabel.Layout.Row = 4;
            app.SurfaceRatioSliderLabel.Layout.Column = 1;
            app.SurfaceRatioSliderLabel.Text = 'Surface Ratio';

            % Create SurfaceRatioSlider_2Label
            app.SurfaceRatioSlider_2Label = uilabel(app.GridLayout);
            app.SurfaceRatioSlider_2Label.WordWrap = 'on';
            app.SurfaceRatioSlider_2Label.Layout.Row = 4;
            app.SurfaceRatioSlider_2Label.Layout.Column = 4;
            app.SurfaceRatioSlider_2Label.Text = 'Surface Ratio';

            % Create SurfaceRatioSlider_3Label
            app.SurfaceRatioSlider_3Label = uilabel(app.GridLayout);
            app.SurfaceRatioSlider_3Label.WordWrap = 'on';
            app.SurfaceRatioSlider_3Label.Layout.Row = 4;
            app.SurfaceRatioSlider_3Label.Layout.Column = 7;
            app.SurfaceRatioSlider_3Label.Text = 'Surface Ratio';

            % Create SurfaceRatioSlider_4Label
            app.SurfaceRatioSlider_4Label = uilabel(app.GridLayout);
            app.SurfaceRatioSlider_4Label.WordWrap = 'on';
            app.SurfaceRatioSlider_4Label.Layout.Row = 4;
            app.SurfaceRatioSlider_4Label.Layout.Column = 10;
            app.SurfaceRatioSlider_4Label.Text = 'Surface Ratio';

            % Create TextAreaP2
            app.TextAreaP2 = uitextarea(app.GridLayout);
            app.TextAreaP2.Editable = 'off';
            app.TextAreaP2.Layout.Row = 5;
            app.TextAreaP2.Layout.Column = [4 6];

            % Create TextAreaP3
            app.TextAreaP3 = uitextarea(app.GridLayout);
            app.TextAreaP3.Editable = 'off';
            app.TextAreaP3.Layout.Row = 5;
            app.TextAreaP3.Layout.Column = [7 9];

            % Create TextAreaP4
            app.TextAreaP4 = uitextarea(app.GridLayout);
            app.TextAreaP4.Editable = 'off';
            app.TextAreaP4.Layout.Row = 5;
            app.TextAreaP4.Layout.Column = [10 12];

            % Create LayerNumberDropDown
            app.LayerNumberDropDown = uidropdown(app.GridLayout);
            app.LayerNumberDropDown.Items = {'1'};
            app.LayerNumberDropDown.ValueChangedFcn = createCallbackFcn(app, @LayerNumberDropDownValueChanged, true);
            app.LayerNumberDropDown.FontSize = 16;
            app.LayerNumberDropDown.Layout.Row = 1;
            app.LayerNumberDropDown.Layout.Column = [3 12];
            app.LayerNumberDropDown.Value = '1';

            % Create LoadLatticeButton
            app.LoadLatticeButton = uibutton(app.LatticePropertiesTab, 'push');
            app.LoadLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @LoadLatticeButtonPushed, true);
            app.LoadLatticeButton.FontSize = 20;
            app.LoadLatticeButton.Position = [10 10 125 33];
            app.LoadLatticeButton.Text = 'Load Lattice';

            % Create ReverseButton
            app.ReverseButton = uibutton(app.LatticePropertiesTab, 'push');
            app.ReverseButton.ButtonPushedFcn = createCallbackFcn(app, @ReverseButtonPushed, true);
            app.ReverseButton.FontSize = 20;
            app.ReverseButton.Position = [145 10 90 33];
            app.ReverseButton.Text = 'Reverse';

            % Create PlotSoundAbsorptionButton
            app.PlotSoundAbsorptionButton = uibutton(app.LatticePropertiesTab, 'push');
            app.PlotSoundAbsorptionButton.ButtonPushedFcn = createCallbackFcn(app, @PlotSoundAbsorptionButtonPushed, true);
            app.PlotSoundAbsorptionButton.FontSize = 20;
            app.PlotSoundAbsorptionButton.Position = [245 10 210 33];
            app.PlotSoundAbsorptionButton.Text = 'Plot Sound Absorption';

            % Create RefreshButton
            app.RefreshButton = uibutton(app.LatticePropertiesTab, 'push');
            app.RefreshButton.ButtonPushedFcn = createCallbackFcn(app, @RefreshButtonPushed, true);
            app.RefreshButton.FontSize = 20;
            app.RefreshButton.Position = [465 10 100 33];
            app.RefreshButton.Text = 'Refresh';

            % Create ResetButton
            app.ResetButton = uibutton(app.LatticePropertiesTab, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.FontSize = 20;
            app.ResetButton.Position = [575 10 100 33];
            app.ResetButton.Text = 'Reset';

            % Create FindaLatticeTab
            app.FindaLatticeTab = uitab(app.TabGroup);
            app.FindaLatticeTab.Title = 'Find a Lattice';
            app.FindaLatticeTab.BackgroundColor = [1 1 1];

            % Create Panel_4
            app.Panel_4 = uipanel(app.FindaLatticeTab);
            app.Panel_4.BorderColor = [0 0 0];
            app.Panel_4.BorderWidth = 2;
            app.Panel_4.BackgroundColor = [1 1 1];
            app.Panel_4.Position = [460 345 225 220];

            % Create GridLayout_2
            app.GridLayout_2 = uigridlayout(app.Panel_4);
            app.GridLayout_2.ColumnWidth = {'fit', '1x', 'fit'};
            app.GridLayout_2.RowHeight = {'fit', 'fit', '1x'};
            app.GridLayout_2.ColumnSpacing = 5;
            app.GridLayout_2.RowSpacing = 2;
            app.GridLayout_2.Padding = [5 5 5 5];
            app.GridLayout_2.BackgroundColor = [1 1 1];

            % Create CellTypeFL
            app.CellTypeFL = uidropdown(app.GridLayout_2);
            app.CellTypeFL.Items = {'Cell Type', 'Strut', 'Plate', 'TPMS', 'None'};
            app.CellTypeFL.ValueChangedFcn = createCallbackFcn(app, @CellTypeFLValueChanged, true);
            app.CellTypeFL.Tag = 'CellLayer1Part1';
            app.CellTypeFL.FontSize = 14;
            app.CellTypeFL.Layout.Row = 2;
            app.CellTypeFL.Layout.Column = [1 2];
            app.CellTypeFL.Value = 'Cell Type';

            % Create Edit_FL
            app.Edit_FL = uibutton(app.GridLayout_2, 'push');
            app.Edit_FL.ButtonPushedFcn = createCallbackFcn(app, @Edit_FLButtonPushed, true);
            app.Edit_FL.FontSize = 14;
            app.Edit_FL.Layout.Row = 2;
            app.Edit_FL.Layout.Column = 3;
            app.Edit_FL.Text = 'Edit';

            % Create TextAreaFL
            app.TextAreaFL = uitextarea(app.GridLayout_2);
            app.TextAreaFL.Editable = 'off';
            app.TextAreaFL.Layout.Row = 3;
            app.TextAreaFL.Layout.Column = [1 3];

            % Create LayerNumberDropDown_2Label
            app.LayerNumberDropDown_2Label = uilabel(app.GridLayout_2);
            app.LayerNumberDropDown_2Label.FontSize = 16;
            app.LayerNumberDropDown_2Label.Layout.Row = 1;
            app.LayerNumberDropDown_2Label.Layout.Column = 1;
            app.LayerNumberDropDown_2Label.Text = 'Layer Number';

            % Create LayerNumberFLDropDown
            app.LayerNumberFLDropDown = uidropdown(app.GridLayout_2);
            app.LayerNumberFLDropDown.Items = {'1'};
            app.LayerNumberFLDropDown.ValueChangedFcn = createCallbackFcn(app, @LayerNumberFLDropDownValueChanged, true);
            app.LayerNumberFLDropDown.FontSize = 16;
            app.LayerNumberFLDropDown.Layout.Row = 1;
            app.LayerNumberFLDropDown.Layout.Column = [2 3];
            app.LayerNumberFLDropDown.Value = '1';

            % Create Panel_3
            app.Panel_3 = uipanel(app.FindaLatticeTab);
            app.Panel_3.BorderColor = [0 0 0];
            app.Panel_3.BorderWidth = 2;
            app.Panel_3.BackgroundColor = [1 1 1];
            app.Panel_3.Position = [5 345 450 220];

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.Panel_3);
            app.GridLayout2.ColumnWidth = {155, '1x', 'fit', 55, 35, 25};
            app.GridLayout2.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit', 'fit'};
            app.GridLayout2.ColumnSpacing = 5;
            app.GridLayout2.RowSpacing = 3;
            app.GridLayout2.Padding = [5 5 5 5];
            app.GridLayout2.BackgroundColor = [1 1 1];

            % Create CrossSectionFLLabel
            app.CrossSectionFLLabel = uilabel(app.GridLayout2);
            app.CrossSectionFLLabel.FontSize = 16;
            app.CrossSectionFLLabel.Layout.Row = 1;
            app.CrossSectionFLLabel.Layout.Column = 1;
            app.CrossSectionFLLabel.Text = 'Cross Section';

            % Create CrossSectionFLDropDown
            app.CrossSectionFLDropDown = uidropdown(app.GridLayout2);
            app.CrossSectionFLDropDown.Items = {'Circular', 'Square'};
            app.CrossSectionFLDropDown.ValueChangedFcn = createCallbackFcn(app, @CrossSectionFLDropDownValueChanged, true);
            app.CrossSectionFLDropDown.FontSize = 16;
            app.CrossSectionFLDropDown.Layout.Row = 1;
            app.CrossSectionFLDropDown.Layout.Column = [2 6];
            app.CrossSectionFLDropDown.Value = 'Circular';

            % Create LengthDiametermmFLSliderLabel
            app.LengthDiametermmFLSliderLabel = uilabel(app.GridLayout2);
            app.LengthDiametermmFLSliderLabel.WordWrap = 'on';
            app.LengthDiametermmFLSliderLabel.FontSize = 16;
            app.LengthDiametermmFLSliderLabel.Layout.Row = 2;
            app.LengthDiametermmFLSliderLabel.Layout.Column = 1;
            app.LengthDiametermmFLSliderLabel.Text = 'Length/Diameter (mm)';

            % Create LengthDiametermmFLSlider
            app.LengthDiametermmFLSlider = uislider(app.GridLayout2);
            app.LengthDiametermmFLSlider.Limits = [10 50];
            app.LengthDiametermmFLSlider.MajorTicks = [10 20 30 40 50];
            app.LengthDiametermmFLSlider.ValueChangedFcn = createCallbackFcn(app, @LengthDiametermmFLSliderValueChanged, true);
            app.LengthDiametermmFLSlider.Layout.Row = 2;
            app.LengthDiametermmFLSlider.Layout.Column = [2 4];
            app.LengthDiametermmFLSlider.FontSize = 16;
            app.LengthDiametermmFLSlider.Value = 30;

            % Create LengthDiametermmFLSliderNumeric
            app.LengthDiametermmFLSliderNumeric = uieditfield(app.GridLayout2, 'numeric');
            app.LengthDiametermmFLSliderNumeric.ValueChangedFcn = createCallbackFcn(app, @LengthDiametermmFLSliderNumericValueChanged, true);
            app.LengthDiametermmFLSliderNumeric.HorizontalAlignment = 'center';
            app.LengthDiametermmFLSliderNumeric.FontSize = 16;
            app.LengthDiametermmFLSliderNumeric.Layout.Row = 2;
            app.LengthDiametermmFLSliderNumeric.Layout.Column = [5 6];
            app.LengthDiametermmFLSliderNumeric.Value = 30;

            % Create FreqLabelFL
            app.FreqLabelFL = uilabel(app.GridLayout2);
            app.FreqLabelFL.FontSize = 16;
            app.FreqLabelFL.Layout.Row = 4;
            app.FreqLabelFL.Layout.Column = 1;
            app.FreqLabelFL.Text = 'Frequency';

            % Create NumberofLayersSpinnerFLLabel
            app.NumberofLayersSpinnerFLLabel = uilabel(app.GridLayout2);
            app.NumberofLayersSpinnerFLLabel.FontSize = 16;
            app.NumberofLayersSpinnerFLLabel.Layout.Row = 3;
            app.NumberofLayersSpinnerFLLabel.Layout.Column = 1;
            app.NumberofLayersSpinnerFLLabel.Text = 'Number of Layers';

            % Create NumberofLayersSpinnerFL
            app.NumberofLayersSpinnerFL = uispinner(app.GridLayout2);
            app.NumberofLayersSpinnerFL.ValueChangingFcn = createCallbackFcn(app, @NumberofLayersSpinnerFLValueChanging, true);
            app.NumberofLayersSpinnerFL.Limits = [1 6];
            app.NumberofLayersSpinnerFL.ValueChangedFcn = createCallbackFcn(app, @NumberofLayersSpinnerFLValueChanged, true);
            app.NumberofLayersSpinnerFL.HorizontalAlignment = 'center';
            app.NumberofLayersSpinnerFL.FontSize = 16;
            app.NumberofLayersSpinnerFL.Layout.Row = 3;
            app.NumberofLayersSpinnerFL.Layout.Column = [2 6];
            app.NumberofLayersSpinnerFL.Value = 1;

            % Create FreqLowerBoundSpinnerFL
            app.FreqLowerBoundSpinnerFL = uispinner(app.GridLayout2);
            app.FreqLowerBoundSpinnerFL.Step = 50;
            app.FreqLowerBoundSpinnerFL.ValueChangingFcn = createCallbackFcn(app, @FreqLowerBoundSpinnerFLValueChanging, true);
            app.FreqLowerBoundSpinnerFL.Limits = [500 6300];
            app.FreqLowerBoundSpinnerFL.ValueChangedFcn = createCallbackFcn(app, @FreqLowerBoundSpinnerFLValueChanged, true);
            app.FreqLowerBoundSpinnerFL.HorizontalAlignment = 'center';
            app.FreqLowerBoundSpinnerFL.FontSize = 16;
            app.FreqLowerBoundSpinnerFL.Layout.Row = 4;
            app.FreqLowerBoundSpinnerFL.Layout.Column = 2;
            app.FreqLowerBoundSpinnerFL.Value = 1000;

            % Create FreqLabelFL2
            app.FreqLabelFL2 = uilabel(app.GridLayout2);
            app.FreqLabelFL2.FontSize = 16;
            app.FreqLabelFL2.Layout.Row = 4;
            app.FreqLabelFL2.Layout.Column = 3;
            app.FreqLabelFL2.Text = 'Hz to';

            % Create FreqUpperBoundSpinnerFL
            app.FreqUpperBoundSpinnerFL = uispinner(app.GridLayout2);
            app.FreqUpperBoundSpinnerFL.Step = 50;
            app.FreqUpperBoundSpinnerFL.ValueChangingFcn = createCallbackFcn(app, @FreqUpperBoundSpinnerFLValueChanging, true);
            app.FreqUpperBoundSpinnerFL.Limits = [500 6300];
            app.FreqUpperBoundSpinnerFL.ValueChangedFcn = createCallbackFcn(app, @FreqUpperBoundSpinnerFLValueChanged, true);
            app.FreqUpperBoundSpinnerFL.Tag = 'Frequency_end';
            app.FreqUpperBoundSpinnerFL.HorizontalAlignment = 'center';
            app.FreqUpperBoundSpinnerFL.FontSize = 16;
            app.FreqUpperBoundSpinnerFL.Layout.Row = 4;
            app.FreqUpperBoundSpinnerFL.Layout.Column = [4 5];
            app.FreqUpperBoundSpinnerFL.Value = 6300;

            % Create ThicknessmmEditFieldFLLabel
            app.ThicknessmmEditFieldFLLabel = uilabel(app.GridLayout2);
            app.ThicknessmmEditFieldFLLabel.WordWrap = 'on';
            app.ThicknessmmEditFieldFLLabel.FontSize = 16;
            app.ThicknessmmEditFieldFLLabel.Layout.Row = 5;
            app.ThicknessmmEditFieldFLLabel.Layout.Column = 1;
            app.ThicknessmmEditFieldFLLabel.Text = 'Maximum Thickness (mm)';

            % Create ThicknessmmEditFieldFL
            app.ThicknessmmEditFieldFL = uieditfield(app.GridLayout2, 'numeric');
            app.ThicknessmmEditFieldFL.ValueChangedFcn = createCallbackFcn(app, @ThicknessmmEditFieldFLValueChanged, true);
            app.ThicknessmmEditFieldFL.HorizontalAlignment = 'center';
            app.ThicknessmmEditFieldFL.FontSize = 16;
            app.ThicknessmmEditFieldFL.Layout.Row = 5;
            app.ThicknessmmEditFieldFL.Layout.Column = [2 6];
            app.ThicknessmmEditFieldFL.Value = 24;

            % Create FreqLabelFL3
            app.FreqLabelFL3 = uilabel(app.GridLayout2);
            app.FreqLabelFL3.FontSize = 16;
            app.FreqLabelFL3.Layout.Row = 4;
            app.FreqLabelFL3.Layout.Column = 6;
            app.FreqLabelFL3.Text = 'Hz';

            % Create NumberofIterationsFL
            app.NumberofIterationsFL = uilabel(app.GridLayout2);
            app.NumberofIterationsFL.WordWrap = 'on';
            app.NumberofIterationsFL.FontSize = 16;
            app.NumberofIterationsFL.Layout.Row = 6;
            app.NumberofIterationsFL.Layout.Column = 1;
            app.NumberofIterationsFL.Text = 'Number of Iterations';

            % Create NumberofIterationsFLSpinner
            app.NumberofIterationsFLSpinner = uispinner(app.GridLayout2);
            app.NumberofIterationsFLSpinner.ValueChangingFcn = createCallbackFcn(app, @NumberofIterationsFLSpinnerValueChanging, true);
            app.NumberofIterationsFLSpinner.Limits = [1 10];
            app.NumberofIterationsFLSpinner.ValueChangedFcn = createCallbackFcn(app, @NumberofIterationsFLSpinnerValueChanged, true);
            app.NumberofIterationsFLSpinner.HorizontalAlignment = 'center';
            app.NumberofIterationsFLSpinner.FontSize = 16;
            app.NumberofIterationsFLSpinner.Layout.Row = 6;
            app.NumberofIterationsFLSpinner.Layout.Column = [2 6];
            app.NumberofIterationsFLSpinner.Value = 1;

            % Create FindLatticeButton
            app.FindLatticeButton = uibutton(app.FindaLatticeTab, 'push');
            app.FindLatticeButton.ButtonPushedFcn = createCallbackFcn(app, @FindLatticeButtonPushed, true);
            app.FindLatticeButton.FontSize = 20;
            app.FindLatticeButton.Position = [10 10 125 33];
            app.FindLatticeButton.Text = 'Find Lattice';

            % Create PlotSACButtonFindLattice
            app.PlotSACButtonFindLattice = uibutton(app.FindaLatticeTab, 'push');
            app.PlotSACButtonFindLattice.ButtonPushedFcn = createCallbackFcn(app, @PlotSACButtonFindLatticePushed, true);
            app.PlotSACButtonFindLattice.FontSize = 20;
            app.PlotSACButtonFindLattice.Position = [150 10 110 33];
            app.PlotSACButtonFindLattice.Text = 'Plot SAC';

            % Create SaveResultsButton
            app.SaveResultsButton = uibutton(app.FindaLatticeTab, 'push');
            app.SaveResultsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveResultsButtonPushed, true);
            app.SaveResultsButton.FontSize = 20;
            app.SaveResultsButton.Position = [275 10 135 33];
            app.SaveResultsButton.Text = 'Save Results';

            % Create ClearResultsButton
            app.ClearResultsButton = uibutton(app.FindaLatticeTab, 'push');
            app.ClearResultsButton.ButtonPushedFcn = createCallbackFcn(app, @ClearResultsButtonPushed, true);
            app.ClearResultsButton.FontSize = 20;
            app.ClearResultsButton.Position = [425 10 135 33];
            app.ClearResultsButton.Text = 'Clear Results';

            % Create ResetFindLattice
            app.ResetFindLattice = uibutton(app.FindaLatticeTab, 'push');
            app.ResetFindLattice.ButtonPushedFcn = createCallbackFcn(app, @ResetFindLatticeButtonPushed, true);
            app.ResetFindLattice.FontSize = 20;
            app.ResetFindLattice.Position = [575 10 100 33];
            app.ResetFindLattice.Text = 'Reset';

            % Create UITable
            app.UITable = uitable(app.FindaLatticeTab);
            app.UITable.ColumnName = {'Name'; 'Thickness'; 'Mean SAC'};
            app.UITable.RowName = {};
            app.UITable.SelectionType = 'row';
            app.UITable.ClickedFcn = createCallbackFcn(app, @UITableClicked, true);
            app.UITable.Multiselect = 'off';
            app.UITable.FontSize = 14;
            app.UITable.Position = [5 55 680 285];

            % Create LatticeSACPlotsandDataTab
            app.LatticeSACPlotsandDataTab = uitab(app.TabGroup);
            app.LatticeSACPlotsandDataTab.Title = 'Lattice SAC Plots and Data';
            app.LatticeSACPlotsandDataTab.BackgroundColor = [1 1 1];

            % Create UIAxes
            app.UIAxes = uiaxes(app.LatticeSACPlotsandDataTab);
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
            app.UIAxes.Position = [5 50 550 515];

            % Create MeanSACEditFieldLabel
            app.MeanSACEditFieldLabel = uilabel(app.LatticeSACPlotsandDataTab);
            app.MeanSACEditFieldLabel.HorizontalAlignment = 'center';
            app.MeanSACEditFieldLabel.FontSize = 16;
            app.MeanSACEditFieldLabel.Position = [560 546 120 25];
            app.MeanSACEditFieldLabel.Text = 'Mean SAC';

            % Create HzLabel_1
            app.HzLabel_1 = uilabel(app.LatticeSACPlotsandDataTab);
            app.HzLabel_1.HorizontalAlignment = 'center';
            app.HzLabel_1.FontSize = 16;
            app.HzLabel_1.Position = [560 397 120 25];
            app.HzLabel_1.Text = '  500 - 1000 Hz';

            % Create MeanSACEditField
            app.MeanSACEditField = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.MeanSACEditField.Editable = 'off';
            app.MeanSACEditField.HorizontalAlignment = 'center';
            app.MeanSACEditField.FontSize = 16;
            app.MeanSACEditField.Position = [560 521 120 25];

            % Create FreqBand_1
            app.FreqBand_1 = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.FreqBand_1.Editable = 'off';
            app.FreqBand_1.HorizontalAlignment = 'center';
            app.FreqBand_1.FontSize = 16;
            app.FreqBand_1.Position = [561 372 120 25];

            % Create StdDevSACEditFieldLabel
            app.StdDevSACEditFieldLabel = uilabel(app.LatticeSACPlotsandDataTab);
            app.StdDevSACEditFieldLabel.HorizontalAlignment = 'center';
            app.StdDevSACEditFieldLabel.FontSize = 16;
            app.StdDevSACEditFieldLabel.Position = [560 497 120 25];
            app.StdDevSACEditFieldLabel.Text = 'StdDev SAC';

            % Create HzLabel_2
            app.HzLabel_2 = uilabel(app.LatticeSACPlotsandDataTab);
            app.HzLabel_2.HorizontalAlignment = 'center';
            app.HzLabel_2.FontSize = 16;
            app.HzLabel_2.Position = [560 347 120 25];
            app.HzLabel_2.Text = '1000 - 2000 Hz';

            % Create StdDevSACEditField
            app.StdDevSACEditField = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.StdDevSACEditField.Editable = 'off';
            app.StdDevSACEditField.HorizontalAlignment = 'center';
            app.StdDevSACEditField.FontSize = 16;
            app.StdDevSACEditField.Position = [560 472 120 25];

            % Create FreqBand_2
            app.FreqBand_2 = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.FreqBand_2.Editable = 'off';
            app.FreqBand_2.HorizontalAlignment = 'center';
            app.FreqBand_2.FontSize = 16;
            app.FreqBand_2.Position = [561 322 120 25];

            % Create NRCEditFieldLabel
            app.NRCEditFieldLabel = uilabel(app.LatticeSACPlotsandDataTab);
            app.NRCEditFieldLabel.HorizontalAlignment = 'center';
            app.NRCEditFieldLabel.FontSize = 16;
            app.NRCEditFieldLabel.Position = [559 446 120 25];
            app.NRCEditFieldLabel.Text = 'NRC';

            % Create HzLabel_3
            app.HzLabel_3 = uilabel(app.LatticeSACPlotsandDataTab);
            app.HzLabel_3.HorizontalAlignment = 'center';
            app.HzLabel_3.FontSize = 16;
            app.HzLabel_3.Position = [560 297 120 25];
            app.HzLabel_3.Text = '2000 - 4000 Hz';

            % Create NRCEditField
            app.NRCEditField = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.NRCEditField.Editable = 'off';
            app.NRCEditField.HorizontalAlignment = 'center';
            app.NRCEditField.FontSize = 16;
            app.NRCEditField.Position = [560 421 120 25];

            % Create FreqBand_3
            app.FreqBand_3 = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.FreqBand_3.Editable = 'off';
            app.FreqBand_3.HorizontalAlignment = 'center';
            app.FreqBand_3.FontSize = 16;
            app.FreqBand_3.Position = [561 272 120 25];

            % Create HzLabel_4
            app.HzLabel_4 = uilabel(app.LatticeSACPlotsandDataTab);
            app.HzLabel_4.HorizontalAlignment = 'center';
            app.HzLabel_4.FontSize = 16;
            app.HzLabel_4.Position = [560 247 120 25];
            app.HzLabel_4.Text = '4000 - 6300 Hz';

            % Create FreqBand_4
            app.FreqBand_4 = uieditfield(app.LatticeSACPlotsandDataTab, 'numeric');
            app.FreqBand_4.Editable = 'off';
            app.FreqBand_4.HorizontalAlignment = 'center';
            app.FreqBand_4.FontSize = 16;
            app.FreqBand_4.Position = [561 222 120 25];

            % Create SaveLatticeDesignButton
            app.SaveLatticeDesignButton = uibutton(app.LatticeSACPlotsandDataTab, 'push');
            app.SaveLatticeDesignButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLatticeDesignButtonPushed, true);
            app.SaveLatticeDesignButton.FontSize = 20;
            app.SaveLatticeDesignButton.Position = [10 11 200 33];
            app.SaveLatticeDesignButton.Text = 'Save Lattice Design';

            % Create ExportLatticeDesignButton
            app.ExportLatticeDesignButton = uibutton(app.LatticeSACPlotsandDataTab, 'push');
            app.ExportLatticeDesignButton.ButtonPushedFcn = createCallbackFcn(app, @ExportLatticeDesignButtonPushed, true);
            app.ExportLatticeDesignButton.FontSize = 20;
            app.ExportLatticeDesignButton.Position = [225 11 200 33];
            app.ExportLatticeDesignButton.Text = 'Export Lattice Design';

            % Create SaveSACPlotandDataButton
            app.SaveSACPlotandDataButton = uibutton(app.LatticeSACPlotsandDataTab, 'push');
            app.SaveSACPlotandDataButton.ButtonPushedFcn = createCallbackFcn(app, @SaveSACPlotandDataButtonPushed, true);
            app.SaveSACPlotandDataButton.FontSize = 20;
            app.SaveSACPlotandDataButton.Position = [440 11 240 33];
            app.SaveSACPlotandDataButton.Text = 'Save SAC Plot and Data';

            % Create BackButton
            app.BackButton = uibutton(app.LatticeSACPlotsandDataTab, 'push');
            app.BackButton.ButtonPushedFcn = createCallbackFcn(app, @BackButtonPushed, true);
            app.BackButton.FontSize = 20;
            app.BackButton.Position = [562 52 118 33];
            app.BackButton.Text = 'Back';

            % Create InstructionsTab
            app.InstructionsTab = uitab(app.TabGroup);
            app.InstructionsTab.Title = 'Instructions';
            app.InstructionsTab.BackgroundColor = [1 1 1];

            % Create Image2
            app.Image2 = uiimage(app.InstructionsTab);
            app.Image2.Position = [1 245 686 325];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'LattSAC_Workflow.PNG');

            % Create LatticePropertiesLabel
            app.LatticePropertiesLabel = uilabel(app.InstructionsTab);
            app.LatticePropertiesLabel.FontSize = 20;
            app.LatticePropertiesLabel.FontWeight = 'bold';
            app.LatticePropertiesLabel.Position = [5 220 197 26];
            app.LatticePropertiesLabel.Text = '1. Lattice Properties';

            % Create LatticeLayersandPartsLabel
            app.LatticeLayersandPartsLabel = uilabel(app.InstructionsTab);
            app.LatticeLayersandPartsLabel.FontSize = 20;
            app.LatticeLayersandPartsLabel.FontWeight = 'bold';
            app.LatticeLayersandPartsLabel.Position = [5 170 261 26];
            app.LatticeLayersandPartsLabel.Text = '2. Lattice Layers and Parts';

            % Create PlotLatticeSACLabel
            app.PlotLatticeSACLabel = uilabel(app.InstructionsTab);
            app.PlotLatticeSACLabel.FontSize = 20;
            app.PlotLatticeSACLabel.FontWeight = 'bold';
            app.PlotLatticeSACLabel.Position = [5 105 183 26];
            app.PlotLatticeSACLabel.Text = '3. Plot Lattice SAC';

            % Create ExportLatticeDesignLabel
            app.ExportLatticeDesignLabel = uilabel(app.InstructionsTab);
            app.ExportLatticeDesignLabel.FontSize = 20;
            app.ExportLatticeDesignLabel.FontWeight = 'bold';
            app.ExportLatticeDesignLabel.Position = [5 41 235 26];
            app.ExportLatticeDesignLabel.Text = '4. Export Lattice Design';

            % Create SpecifyyourLabel
            app.SpecifyyourLabel = uilabel(app.InstructionsTab);
            app.SpecifyyourLabel.FontSize = 14;
            app.SpecifyyourLabel.Position = [5 200 679 22];
            app.SpecifyyourLabel.Text = 'Specify your lattice cross-section, sample length/diameter, number of different layers and frequency range.';

            % Create SpecifyyourLabel_2
            app.SpecifyyourLabel_2 = uilabel(app.InstructionsTab);
            app.SpecifyyourLabel_2.FontSize = 14;
            app.SpecifyyourLabel_2.Position = [5 135 652 35];
            app.SpecifyyourLabel_2.Text = {'For each layer, use the table to edit individual lattice parts. You can stack parts in parallel.'; 'You are required to specify the cell type (Strut, Plate, etc.) of each part to be included into your design.'};

            % Create SpecifyyourLabel_3
            app.SpecifyyourLabel_3 = uilabel(app.InstructionsTab);
            app.SpecifyyourLabel_3.WordWrap = 'on';
            app.SpecifyyourLabel_3.FontSize = 14;
            app.SpecifyyourLabel_3.Position = [5 70 684 35];
            app.SpecifyyourLabel_3.Text = 'The app plots out the sound absorption coefficient (SAC), as well as the mean, standard deviation, and noise reduction coefficient (NRC). Mean SACs for various frequency bands were also shown.';

            % Create SpecifyyourLabel_4
            app.SpecifyyourLabel_4 = uilabel(app.InstructionsTab);
            app.SpecifyyourLabel_4.WordWrap = 'on';
            app.SpecifyyourLabel_4.FontSize = 14;
            app.SpecifyyourLabel_4.Position = [5 7 684 35];
            app.SpecifyyourLabel_4.Text = {'You can export the SAC plot and statistics into a figure file and text file respectively. '; 'You can also export the lattice design into an external file for reference.'};

            % Create AboutThisApplicationTab
            app.AboutThisApplicationTab = uitab(app.TabGroup);
            app.AboutThisApplicationTab.Title = 'About This Application';
            app.AboutThisApplicationTab.BackgroundColor = [1 1 1];

            % Create WhatisLattSACLabel
            app.WhatisLattSACLabel = uilabel(app.AboutThisApplicationTab);
            app.WhatisLattSACLabel.FontSize = 20;
            app.WhatisLattSACLabel.FontWeight = 'bold';
            app.WhatisLattSACLabel.Position = [10 540 175 25];
            app.WhatisLattSACLabel.Text = 'What is LattSAC?';

            % Create TextArea
            app.TextArea = uitextarea(app.AboutThisApplicationTab);
            app.TextArea.FontSize = 16;
            app.TextArea.Position = [10 450 670 85];
            app.TextArea.Value = {'LattSAC is a lattice design and modeling application that designs various lattice sound-absorbing materials by inputting only the necessary geometry parameters. The software then calculates the sound absorption coefficients (SAC) of the lattice sound absorber with insights into the mean performances over selected frequency bands.'};

            % Create WhatUnitCellDesignsareavailableLabel
            app.WhatUnitCellDesignsareavailableLabel = uilabel(app.AboutThisApplicationTab);
            app.WhatUnitCellDesignsareavailableLabel.FontSize = 20;
            app.WhatUnitCellDesignsareavailableLabel.FontWeight = 'bold';
            app.WhatUnitCellDesignsareavailableLabel.Position = [10 415 365 25];
            app.WhatUnitCellDesignsareavailableLabel.Text = 'What Unit Cell Designs are available?';

            % Create ContactsLabel
            app.ContactsLabel = uilabel(app.AboutThisApplicationTab);
            app.ContactsLabel.FontSize = 20;
            app.ContactsLabel.FontWeight = 'bold';
            app.ContactsLabel.Position = [7 100 365 26];
            app.ContactsLabel.Text = 'Contacts';

            % Create TextArea_2
            app.TextArea_2 = uitextarea(app.AboutThisApplicationTab);
            app.TextArea_2.FontSize = 16;
            app.TextArea_2.Position = [10 10 670 85];
            app.TextArea_2.Value = {'If there are any bugs, suggestions or contributions, the user may write to zhaiweigroup@gmail.com. '; 'Alternatively (Until May 2025), you can write in directly to me (Chua Jun Wei) at chua.junwei@u.nus.edu.'};

            % Create Image
            app.Image = uiimage(app.AboutThisApplicationTab);
            app.Image.Position = [10 134 670 276];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'LattSAC_UnitCells.png');

            % Create DesignedBy
            app.DesignedBy = uilabel(app.UIFigure);
            app.DesignedBy.VerticalAlignment = 'top';
            app.DesignedBy.WordWrap = 'on';
            app.DesignedBy.FontSize = 16;
            app.DesignedBy.FontAngle = 'italic';
            app.DesignedBy.Position = [2 1 350 22];
            app.DesignedBy.Text = 'Designed by Chua Jun Wei for NUS Zhai Group.';

            % Create VersionNum
            app.VersionNum = uilabel(app.UIFigure);
            app.VersionNum.HorizontalAlignment = 'right';
            app.VersionNum.VerticalAlignment = 'top';
            app.VersionNum.WordWrap = 'on';
            app.VersionNum.FontSize = 16;
            app.VersionNum.FontAngle = 'italic';
            app.VersionNum.Position = [441 1 260 22];
            app.VersionNum.Text = 'Version 1.2.0. ';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = LattSAC_exported

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
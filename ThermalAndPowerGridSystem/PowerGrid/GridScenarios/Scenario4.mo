within ThermalAndPowerGridSystem.PowerGrid.GridScenarios;

model Scenario4
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.PowerGrid.Utilities.WindGenerationData windGenerationData(windGenerationDataFile = scenario4Parameters.windGenerationDataFile)  annotation(
    Placement(visible = true, transformation(origin = {-93, 39}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem powerManagementSystem(V = scenario4Parameters.V, chargingStationCost = scenario4Parameters.chargingStationCost, dosmesticDemandCost = scenario4Parameters.dosmesticDemandCost, energyStorageCost = scenario4Parameters.energyStorageCost, solarGenCost = scenario4Parameters.solarGenCost, storageSupplyPowerLimit = scenario4Parameters.storageSupplyPowerLimit, tndEfficiency = scenario4Parameters.tndEfficiency, windGenCost = scenario4Parameters.windGenCost)  annotation(
    Placement(visible = true, transformation(origin = {-1.11022e-16, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.GenerationFactor windGenerationFactor(Factor = scenario4Parameters.windGenerationFactor) annotation(
    Placement(visible = true, transformation(origin = {-52, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.DomesticConsumer domesticConsumer(domesticDemandData = scenario4Parameters.domesticDemandData)  annotation(
    Placement(visible = true, transformation(origin = {68, -20}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Components.Kpi kpi annotation(
    Placement(visible = true, transformation(origin = {0, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ChargingStation chargingStation(bikeChargingDuration = scenario4Parameters.bikeChargingDuration, carChargingDuration = scenario4Parameters.carChargingDuration, evBikeCapacity = scenario4Parameters.evBikeCapacity, evBikeChargingRating = scenario4Parameters.evBikeChargingRating, evCarCapacity = scenario4Parameters.evCarCapacity, evCarChargingRating = scenario4Parameters.evCarChargingRating, maxNumberOfBikePerChargingStation = scenario4Parameters.maxNumberOfBikePerChargingStation, maxNumberOfCarPerChargingStation = scenario4Parameters.maxNumberOfCarPerChargingStation, minNumberOfBikePerChargingStation = scenario4Parameters.minNumberOfBikePerChargingStation, minNumberOfCarPerChargingStation = scenario4Parameters.minNumberOfCarPerChargingStation, numberOfChargingStation = scenario4Parameters.numberOfChargingStation)  annotation(
    Placement(visible = true, transformation(origin = {68, 20}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.EnergyStorage energyStorage(maxEnergyPercentage = scenario4Parameters.maxEnergyPercentage, minEnergyPercentage = scenario4Parameters.minEnergyPercentage, storageCapacity = scenario4Parameters.storageCapacity)  annotation(
    Placement(visible = true, transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ConventionalGrid conventionalGrid annotation(
    Placement(visible = true, transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters scenario4Parameters(PvGenerationEfficiency = 0, TurbineGenrationEfficiency = 0, airDensity = 0, domesticDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountryElectricityDemand.txt"), maxNumberOfBikePerChargingStation = 20, maxNumberOfCarPerChargingStation = 12, numberOfChargingStation = 20000, numberOfTurbines = 0, numberofPvPanels = 0, pvSurfaceArea = 0, pvTiltAngle = 0, solarGenerationFactor = 10, solarIrradianceData = "0", storageCapacity = 100e6, storageSupplyPowerLimit = 500e6, turbineRotorRadius = 0, windGeneratedPowerLimit = 0, windGenerationFactor = 10, windSpeedData = "0")  annotation(
    Placement(visible = true, transformation(origin = {60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SolarGenerationData solarGenerationData(solarGenerationDataFile = scenario4Parameters.solarGenerationDataFile) annotation(
    Placement(visible = true, transformation(origin = {-93, -21}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.GenerationFactor solarGenerationFactor(Factor = scenario4Parameters.solarGenerationFactor) annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(powerManagementSystem.chargingStationDemandPort, chargingStation.electricalPort) annotation(
    Line(points = {{22, 10}, {40, 10}, {40, 20}, {54, 20}}));
  connect(powerManagementSystem.domesticDemandPort, domesticConsumer.electricalPort) annotation(
    Line(points = {{22, -10}, {40, -10}, {40, -20}, {54, -20}}));
  connect(energyStorage.electricalPort, powerManagementSystem.storagePort) annotation(
    Line(points = {{-20, -58}, {-20, -40}, {-14, -40}, {-14, -22}}));
  connect(conventionalGrid.electricalPort, powerManagementSystem.sourceSinkPort) annotation(
    Line(points = {{20, -58}, {20, -40}, {14, -40}, {14, -22}}));
  connect(windGenerationData.windGenerationPower, windGenerationFactor.electricalPortIn) annotation(
    Line(points = {{-77.7, 30.5}, {-65.7, 30.5}}));
  connect(energyStorage.storageCapacityOut, kpi.StorageCapacity) annotation(
    Line(points = {{-28, -58}, {-28, 40}, {-8, 40}, {-8, 58}}, color = {0, 0, 127}));
  connect(energyStorage.StorageEnergyOut, kpi.StorageEnergy) annotation(
    Line(points = {{-24, -58}, {-26, -58}, {-26, 38}, {-6, 38}, {-6, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.availableChargingStationDemandPowerOut, kpi.ChargingStationDemandPowerIn) annotation(
    Line(points = {{-16, 22}, {-16, 36}, {-4, 36}, {-4, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.availableDomesticDemandPowerOut, kpi.domesticDemandPowerIn) annotation(
    Line(points = {{-10, 22}, {-10, 34}, {-2, 34}, {-2, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.availableSolarGeneratedPowerOut, kpi.solarGeneratedPowerIn) annotation(
    Line(points = {{-4, 22}, {-4, 32}, {2, 32}, {2, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.availableWindGeneratedPowerOut, kpi.windGeneratedPowerIn) annotation(
    Line(points = {{4, 22}, {4, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.powerTransferedToStorageOut, kpi.storagePowerIn) annotation(
    Line(points = {{10, 22}, {10, 32}, {6, 32}, {6, 58}}, color = {0, 0, 127}));
  connect(powerManagementSystem.powerTransferedToGridOut, kpi.conventionalGridPowerIn) annotation(
    Line(points = {{16, 22}, {16, 34}, {8, 34}, {8, 58}}, color = {0, 0, 127}));
  connect(energyStorage.canDischarge, powerManagementSystem.canDischarge) annotation(
    Line(points = {{-16, -58}, {-16, -44}, {-6, -44}, {-6, -22}}, color = {255, 0, 255}));
  connect(energyStorage.canCharge, powerManagementSystem.canCharge) annotation(
    Line(points = {{-12, -58}, {-12, -46}, {6, -46}, {6, -22}}, color = {255, 0, 255}));
  connect(solarGenerationData.solarGenerationPower, solarGenerationFactor.electricalPortIn) annotation(
    Line(points = {{-77.7, -29.5}, {-63.7, -29.5}}));
  connect(windGenerationFactor.electricalPortOut, powerManagementSystem.windGenerationPort) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 10}, {-22, 10}}));
  connect(solarGenerationFactor.electricalPortOut, powerManagementSystem.solarGenerationPort) annotation(
    Line(points = {{-36, -30}, {-30, -30}, {-30, -10}, {-22, -10}}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 90}, extent = {{100, -10}, {-100, 10}}, textString = "Country (Netherland) Grid Scenario", fontSize = 20)}),
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-6, Interval = 3600));
end Scenario4;

within ThermalAndPowerGridSystem.PowerGrid.Utilities;

record SystemParameters "System Parameters"

  extends Icons.Parameters_Icon;
  import SI = Modelica.Units.SI;
  import nSI = Modelica.Units.NonSI;
   //Wind Speed Parameters
  parameter SI.Density airDensity = 1.225 "Air Density (kg/m3)";
  parameter String windSpeedData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/WindSpeed.txt");
  //Wind Turbine Parameters
  parameter SI.Radius turbineRotorRadius = 30 "Turbine Rotor Blade Radius";
  parameter SI.Efficiency TurbineGenrationEfficiency = 0.8 " Turbine Electrical Power Generation Efficiency";
  parameter Real numberOfTurbines = 3;
  parameter SI.Power windGeneratedPowerLimit = 2e6 " Wind Generator Power Generation Limit (W)";
  //Solar Irradiance Parameter
  parameter Real pvTiltAngle = 30 " PV tilt angle(deg) with respect to Horizontal facing south";
  parameter String solarIrradianceData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/SolarIrradiance.txt");
  //Solar Farm PV Panel Parameters
  parameter SI.Efficiency PvGenerationEfficiency = 0.4 "PV Panel Electrical Power Generation Efficiency";
  parameter SI.Area pvSurfaceArea = 2 " PV Panels Cumulative Surface Area (m2)";
  parameter Real numberofPvPanels = 1000;
  //Solar Generation 
  parameter String solarGenerationDataFile = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountrySolarGeneration.txt");
  parameter Real solarGenerationFactor = 1;
  //Wind Generation 
  parameter String windGenerationDataFile = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountryWindGeneration.txt");
  parameter Real windGenerationFactor = 1;
  //Energy Storage Parameters
  parameter nSI.Energy_Wh storageCapacity = 5e6 " Storage Maximum capacity (Whr)";
  parameter Real maxEnergyPercentage = 95 "Maximum Percentage Energy Limt (%)";
  parameter Real minEnergyPercentage = 5 "Minimum Percentage Energy Limt (%)";
  //Power Management System Parameters
  parameter Real solarGenCost = 10 "Cost for Power generated from solar (per unit cost)";
  parameter Real windGenCost = 10 "Cost for Power generated from wind (per unit cost)";
  parameter Real energyStorageCost = 10 "Cost for Storing energy (per unit cost)";  
  parameter Real dosmesticDemandCost = 10 "Cost for Power demand by consumers (per unit cost)";
  parameter Real chargingStationCost = 10 "Cost for Power utilisied by charging station (per unit cost)";
  parameter SI.Efficiency tndEfficiency = 0.9 " Transmission & Distribution Efficiency";
  parameter SI.Voltage V =11e3 " Grid Voltage (dummy variable)";
  parameter SI.Power storageSupplyPowerLimit = 0.5e6 "Charge & Discharge Power Limit of the energy storage";
 //Charging Stations Parameter
  parameter nSI.Energy_Wh evCarCapacity = 60e3;
  parameter SI.Power evCarChargingRating = 11e3;
  parameter nSI.Energy_Wh evBikeCapacity = 4200;
  parameter SI.Power evBikeChargingRating = 1e2;
  parameter Integer maxNumberOfBikePerChargingStation = 20;
  parameter Integer maxNumberOfCarPerChargingStation = 12;
  parameter Integer minNumberOfBikePerChargingStation = 0;
  parameter Integer minNumberOfCarPerChargingStation = 0;
  parameter Integer numberOfChargingStation = 4;
  parameter Real bikeChargingDuration(unit = "Hour") = 3;
  parameter Real carChargingDuration(unit = "Hour") = 6;

//Domestic Demand Parameters
  parameter String domesticDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/SingleHouseElectricityDemand.txt");
  annotation(
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">This record defines parameters used in this Power Grid model. By changing parameters, different conditons can be tested.</span><!--EndFragment--></body></html>"),
    Icon);

end SystemParameters;

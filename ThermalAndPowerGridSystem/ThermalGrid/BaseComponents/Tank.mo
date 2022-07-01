within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

partial model Tank "The input-output enthalpy change, level of medium in the tank, enthalpy storage, output pressure are modeled"
  extends SystemSetup.SystemFluid;
  outer SystemSetup.AmbientConditions ambientConditions;
  SystemSetup.Constants constants;
 
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Volume;
  import Modelica.Units.SI.Height;
  import HTC = Modelica.Units.SI.CoefficientOfHeatTransfer;
  import Modelica.Units.SI.Power;
  import DeltaP = Modelica.Units.SI.PressureDifference;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.Density;
  import Modelica.Units.SI.Enthalpy;
  
  parameter AbsolutePressure PTop = ambientConditions.PAtm;
  parameter AbsoluteTemperature TAmb = ambientConditions.Tambient;
  parameter Volume tankVolume = 300;
  parameter Area tankArea = 10;
  parameter Area tankSurfaceArea = 1 "dummy Value";
  parameter Height maxHeight = tankVolume / tankArea;
  parameter Height radius = sqrt(tankArea/constants.pi);
  parameter HTC tankHTC = 1 "Heat Transfer Coefficient of tank";
  parameter Height InitialLevel = 10;
  
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portA annotation(
    Placement(visible = true, transformation(origin = {-80, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portB annotation(
    Placement(visible = true, transformation(origin = {84, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput levelSensor annotation(
    Placement(visible = true, transformation(origin = {84, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput tempSensor annotation(
    Placement(visible = true, transformation(origin = {106, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Height level(max = maxHeight);
  Density liquidDensity;
  AbsoluteTemperature temperatureTank;
  SpecificEnthalpy specificEnthalpyTank;
  Enthalpy enthalpyTank;
  Power Qloss;
  Area surfaceArea;
  Real EnthRatio = enthalpyTank / (level * liquidDensity);
 
 initial equation
  level = InitialLevel;
  specificEnthalpyTank = FluidWater.specificEnthalpy_pTX(PTop, TAmb, {1});
equation
  if cardinality(portA) == 0 then
    portA.massFlowRate = 2000;
    portA.pressure = ambientConditions.PAtm;
    portA.specificEnthalpy = FluidMedium.specificEnthalpy_pTX(portA.pressure, TAmb, {1});
  end if;

  levelSensor = level;
  tempSensor =  temperatureTank;
  liquidDensity = FluidWater.density_phX(portB.pressure, specificEnthalpyTank, {1});
  portA.massFlowRate + portB.massFlowRate = tankArea * der(level * liquidDensity);
  portA.pressure = PTop;
  portB.pressure = liquidDensity * constants.g * level + PTop;
  portA.specificEnthalpy = inStream(portA.specificEnthalpy);  
  portB.specificEnthalpy = specificEnthalpyTank;
  temperatureTank = FluidWater.temperature_phX(portB.pressure, specificEnthalpyTank, {1});
  surfaceArea = 2*constants.pi*radius*level;
  Qloss = tankHTC * surfaceArea * (temperatureTank - TAmb);
  specificEnthalpyTank * (tankArea * level * liquidDensity) = enthalpyTank;
  der(enthalpyTank) = portA.massFlowRate * actualStream(portA.specificEnthalpy) + portB.massFlowRate * actualStream(portB.specificEnthalpy)/* - Qloss*/;


end Tank;

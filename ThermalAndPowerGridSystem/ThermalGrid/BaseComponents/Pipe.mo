within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

partial model Pipe "This model calculates the friction coefficient of the pipe, pressure drop across the pipe as well as energy losses."

  extends SystemSetup.SystemFluid;
  SystemSetup.Constants constants;
  
  inner SystemSetup.AmbientConditions ambientConditions;
  import Modelica.Units.SI.Length;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import DelP = Modelica.Units.SI.PressureDifference;
  import Modelica.Units.SI.Velocity;
  import Modelica.Units.SI.Area;
  import Pressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import HTC = Modelica.Units.SI.CoefficientOfHeatTransfer;
  import Modelica.Units.SI.PerUnit;
  import Modelica.Units.SI.Density;
  import Modelica.Units.SI.Power;
 
  parameter Length length = 5000 "Length of pipe";
  parameter Length diameter = 0.3 "Diameter of pipe";
  parameter AbsoluteTemperature T0 = ambientConditions.Tambient "Ambient Temperature";
  //  parameter HTC Qinsulation = 0.0035 "Heat transmission coefficient of pipe";
  parameter PerUnit QpercentageLoss = 0.1 "Percentage of Heat Loss based on ambient conditions";
  
  PerUnit frictionCoeff(start = 0.0035) "Frictional Coefficient of pipe ";
  PerUnit Re(start = 2000,fixed=true) "Reynolds number";
  Velocity velocity "Velocity of medium through pipe";
  Area area "Cross sectional area of the pipe";
  Power Qloss "Heat loss over insulation";
   Power Qpipe;
  Density liquidDensity;
  DelP delP " Pressure drop across pipe based on pipe roughness";
  AbsoluteTemperature tPipe;
  AbsoluteTemperature supplyTemperature;
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portA annotation(
    Placement(visible = true, transformation(origin = {-110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portB annotation(
    Placement(visible = true, transformation(origin = {110, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  portA.massFlowRate + portB.massFlowRate = 0;
  portB.pressure = portA.pressure - delP;
  0 = portA.massFlowRate*inStream(portA.specificEnthalpy) +portB.massFlowRate*inStream(portB.specificEnthalpy) - Qloss;

  Re = diameter * velocity * liquidDensity / 0.001;
  if Re<=0 then 
    frictionCoeff = 0;
  elseif Re <= 2000 then
      frictionCoeff = 16 / Re;
  elseif Re > 4000 and Re < 10 ^ 6 then
      frictionCoeff = 0.079 / Re ^ (1 / 4);
  else
      frictionCoeff = 0.0035;
  end if;
 
  liquidDensity = FluidWater.density_phX(portB.pressure, portB.specificEnthalpy, {1});
  tPipe = FluidWater.temperature_phX(portB.pressure, portB.specificEnthalpy, {1});
   area = constants.pi * diameter ^ 2 / 4;
  velocity = portA.massFlowRate / (area * liquidDensity);
  delP = 2 * frictionCoeff * length * liquidDensity * velocity ^ 2 / diameter;
    //Heat Loss
   // Qloss = Qinsulation * length * (tPipe - T0);
   Qloss = Qpipe*QpercentageLoss;
   Qpipe = liquidDensity * portA.massFlowRate * 4184 * (tPipe - T0);
  supplyTemperature = FluidWater.temperature_phX(portB.pressure, portB.specificEnthalpy, {1});
end Pipe;

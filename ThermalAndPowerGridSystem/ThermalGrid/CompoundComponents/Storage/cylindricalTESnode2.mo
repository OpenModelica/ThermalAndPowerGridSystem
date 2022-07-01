within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.Storage;

model cylindricalTESnode2 "Stratified Tank Model...Geometry: Cylinder"
   // extends Icons.StratifiedTank;
  extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.SystemFluid;
  extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.AmbientConditions;
  extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.Constants;
  import Modelica.Units.SI.PerUnit;
  import Modelica.Units.SI.Density;
  import Modelica.Units.SI.SpecificHeatCapacity;
  import Modelica.Units.SI.ThermalConductivity;
  import Modelica.Units.SI.VolumeFlowRate;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Energy;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.Height;
  import Modelica.Units.SI.Radius;
  import Modelica.Units.SI.Length;
  import Modelica.Units.SI.Angle;
  import Modelica.Units.SI.Pressure;
  
  parameter Radius radiusTank = 25.25;
  parameter PerUnit Uside = 0.3, Utop = 0.1 "Heat transfer coefficient";
  /*parameter*/
  Area areaNode = radiusTank * radiusTank * pi "Cross-sectional area of a segment";
  parameter Height heightNode = 5 " Height of each segment";
  //parameter Height heightTank = 50;
  Integer mode "1 - charging, 2 - storage/idle, 3 - discharging";
  /*(start=1,fixed=true)*/
  PerUnit pi = Modelica.Constants.pi;
  Density density "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  Height perimeterNode "Surface area of a segment";
  Energy QlossNode;
  AbsoluteTemperature Tnode, inletTemperature;
  
  /*= 95 + 273*/
  /* Tground = 298,*/
  VolumeFlowRate Vw "Volume Flowrate of medium";
  /* =1000*/
  Area areaTop " Cross-sectional area of first and last segment respectively";
  /*, areaBottom*/
  Real hour;
 
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort hotIn annotation(
    Placement(visible = true, transformation(origin = {-80, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort hotOut annotation(
    Placement(visible = true, transformation(origin = {80, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort coldOut annotation(
    Placement(visible = true, transformation(origin = {-80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort coldIn annotation(
    Placement(visible = true, transformation(origin = {80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput cummHeightNode annotation(
    Placement(visible = true, transformation(origin = {1, -55}, extent = {{-11, -11}, {11, 11}}, rotation = -90), iconTransformation(origin = {0, -54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput heightPreviousNode annotation(
    Placement(visible = true, transformation(origin = {-6, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {2.22045e-16, 72}, extent = {{-12, -12}, {12, 12}}, rotation = -90)));
initial equation

  Tnode = 333;

equation
  density = 1000;
  cp = 4200;
  thermalConductivity = 0.6;
  areaTop = pi * radiusTank * radiusTank;

if mode ==1 then  
Vw = hotIn.massFlowRate/density;
     inletTemperature =FluidWater.temperature_phX(hotIn.pressure,hotIn.specificEnthalpy , {1});
      density * areaNode * cp * der(Tnode) = density * Vw * cp * (inletTemperature - Tnode) - QlossNode;
      hotIn.pressure=PAtm;
      coldOut.pressure = hotIn.pressure +density*g*cummHeightNode;
     
      coldOut.specificEnthalpy= FluidWater.specificEnthalpy_pTX(coldOut.pressure,Tnode , {1});
       hotIn.massFlowRate+coldOut.massFlowRate = 0;
         
        hotOut.specificEnthalpy = inStream(hotIn.specificEnthalpy); //check
        hotOut.pressure = PAtm;
        hotOut.massFlowRate = 0;   
elseif mode ==2 then 
 Vw =coldIn.massFlowRate/density;
      inletTemperature = FluidWater.temperature_phX(coldIn.pressure,coldIn.specificEnthalpy , {1});
      density * areaNode * cp * der(Tnode) = density * Vw * cp * (inletTemperature - Tnode) - QlossNode;     
      
      coldIn.pressure = hotOut.pressure +density*g*cummHeightNode;
      hotOut.pressure = PAtm;
      
      hotOut.specificEnthalpy= FluidWater.specificEnthalpy_pTX(hotOut.pressure,Tnode , {1});
      coldIn.massFlowRate+hotOut.massFlowRate = 0;
      
      coldOut.specificEnthalpy =inStream(coldIn.specificEnthalpy); //check
      coldOut.pressure = PAtm;
      coldOut.massFlowRate = 0;
//      else //needs to be corrected
//Vw =0;
//     inletTemperature = Tambient;
//     density * areaNode * cp * der(Tnode) = /*density * Vw * cp * (inletTemperature - Tnode)*/ - QlossNode;          
//     hotIn.massFlowRate + coldOut.massFlowRate=0;
//     coldIn.massFlowRate + hotOut.massFlowRate =0;
//     hotIn.specificEnthalpy = inStream(hotIn.specificEnthalpy);
//     hotOut.pressure = hotIn.pressure;
//     coldIn.pressure = coldOut.pressure;
end if;    
  hour = mod(div(time, 3600), 24);

  perimeterNode = radiusTank * 2 * pi * heightNode;

  QlossNode = Uside * perimeterNode * (Tnode - Tground);

 cummHeightNode = heightPreviousNode+heightNode;
   annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 63072),
    Diagram(graphics = {Rectangle(origin = {0.454201, 7.43058}, lineThickness = 1.25, extent = {{-99.5142, 50.4494}, {99.5142, -50.4494}}), Rectangle(origin = {0.25, 7.47}, fillColor = {255, 117, 25}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-95.67, 47.02}, {95.67, -47.02}})}),
    Icon(graphics = {Rectangle(origin = {0.454201, 7.43058}, lineThickness = 1.25, extent = {{-99.5142, 50.4494}, {99.5142, -50.4494}}), Rectangle(origin = {0.25, 7.47}, fillColor = {255, 117, 25}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-95.67, 47.02}, {95.67, -47.02}})}));
end cylindricalTESnode2;

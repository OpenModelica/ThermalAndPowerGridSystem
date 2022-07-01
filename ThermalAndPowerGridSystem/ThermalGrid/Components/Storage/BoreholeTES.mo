within ThermalAndPowerGridSystem.ThermalGrid.Components.Storage;

model BoreholeTES "Stratified Tank Model...Geometry: Cylinder"
 extends Icons.StratifiedTank;
  //extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.SystemFluid;
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
 
  parameter Real SingleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFESingleDer(N = node, z = points, L = heightTank);
  parameter Real DoubleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFEDoubleDer(N = node, z = points, L = heightTank);
  parameter Real points[node] = linspace(0, heightTank, node);
  parameter Integer node = 10 "Number of nodes that the TES is assumed to be divided into";
  parameter Radius radiusTank = /*50*/ 25.25;
  parameter Height heightTank = /*1000*/ 50;
  
  PerUnit pi = Modelica.Constants.pi;
  Density density "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  /*parameter*/ VolumeFlowRate Vw /* =1000*/"Volume Flowrate of medium";
  Area areaOfNode[node] "Cross-sectional area of a segment";
  Area areaTop, areaBottom " Cross-sectional area of first and last segment respectively";
  Height perimeter[node] "Perimeter of a segment";
  Height heightNode[node] " Height of each segment";
  Energy Qloss[node];
  AbsoluteTemperature Tnode[node, 1], Tvariation[node], Tground = 298;
  Real hour, days;
  Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  //Tground[node];
  parameter PerUnit Uside = 0.3 "Heat transfer coefficient";
  //Boolean charging "=1 if charging =0 if discharging";
initial equation
  for a in 1:node loop
//    if a == 1 then
//      Tnode[a, 1] = 368.0;
//    elseif a == node then
//      Tnode[a, 1] = 343;
//    else
      Tnode[a, 1] - (273 + 90) = -30 / heightTank * points[a];
//    end if;
  end for;
  
equation
  density = 1000;
  cp = 4200;
  thermalConductivity = 0.6;
  
  areaTop = areaOfNode[1];
  areaBottom = areaOfNode[node];
  
  heightNode = fill(heightTank / node, node);
  areaOfNode = fill(2 * pi * radiusTank ^ 2, node);
  
  hour = mod(div(time, 3600), 24);
  days = div(time, 3600 * 24);
//   if days < cumDays[3] - 1e-8 then
//     Vw = 0.5;
//  elseif days<cumDays[6] - 1e-8 then 
//     Vw = 0;
//  elseif days<cumDays[9] - 1e-8 then
//    Vw = -0.5;
//  else
//    Vw = 0;
//  end if;          
  
  
  for i in 1:node loop
    perimeter[i] = radiusTank * 2 * pi * heightNode[i];
    if i == 1 then
      Qloss[i]= areaTop *0.1 /*Uside*/ * (Tnode[i, 1] - Tground) + (Uside * perimeter[i] * (Tnode[i, 1] - Tground));
    elseif i == node then
      Qloss[i] = areaBottom * Uside * (Tnode[i, 1] - Tground) + (Uside * perimeter[i] * (Tnode[i, 1] - Tground));
    else
      Qloss[i] = Uside * perimeter[i] * (Tnode[i, 1] - Tground);
    end if;
  end for;
  
  for i in 1:node loop
    density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*(density * Vw * cp * (SingleDer[i, :] * Tnode[:, 1]))*/ + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
  end for;
  Tvariation[:] = Tnode[:, 1];
  
  annotation(experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
end BoreholeTES;

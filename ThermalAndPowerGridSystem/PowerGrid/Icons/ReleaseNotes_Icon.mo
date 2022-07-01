within ThermalAndPowerGridSystem.PowerGrid.Icons;

partial class ReleaseNotes_Icon "Icon for release notes in documentation"

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Polygon(
          points={{-80,-100},{-80,100},{0,100},{0,20},{80,20},{80,-100},{-80,
              -100}},
          fillColor={245,245,245},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,100},{80,20},{0,20},{0,100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{2,-12},{50,-12}}),
        Ellipse(
          extent={{-56,2},{-28,-26}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{2,-60},{50,-60}}),
        Ellipse(
          extent={{-56,-46},{-28,-74}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This icon indicates release notes and the revision history of a library.</p>
</html>"));

end ReleaseNotes_Icon;

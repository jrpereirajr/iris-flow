Class dc.irisflow.rest.Dispatch Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>

<Route Url="/components" Method="GET" Call="dc.irisflow.rest.Editor:ListAllComponents" Cors="true"/>
<Route Url="/flow/generate" Method="POST" Call="dc.irisflow.rest.Editor:GenerateProduction" Cors="true"/>
<Route Url="/flow/save" Method="POST" Call="dc.irisflow.rest.Editor:SaveDiagram" Cors="true"/>
<Route Url="/flow/get/:diagramName" Method="GET" Call="dc.irisflow.rest.Editor:GetDiagram" Cors="true"/>

</Routes>
}

}

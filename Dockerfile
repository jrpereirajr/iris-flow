ARG IMAGE=intersystemsdc/irishealth-community:2020.3.0.200.0-zpm
ARG IMAGE=intersystemsdc/iris-community:2020.4.0.547.0-zpm
ARG IMAGE=containers.intersystems.com/intersystems/iris:2021.1.0.215.0
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

ARG SYSTEM_PWD="SYS"
ARG TELEGRAM_APIKEY
ARG CLIMATIQ_APIKEY

WORKDIR /home/irisowner/irisbuild

ARG TESTS=0
ARG MODULE="iris-flow"
ARG NAMESPACE="USER"

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris session iris "##class(dc.irisflow.util.Setup).ChangePassword(\"_system\",\"$SYSTEM_PWD\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).ChangePassword(\"CSPSystem\",\"$SYSTEM_PWD\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).ChangePassword(\"Admin\",\"$SYSTEM_PWD\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).ChangePassword(\"_Ensemble\",\"$SYSTEM_PWD\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).ChangePassword(\"irisowner\",\"$SYSTEM_PWD\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).DisabledUser(\"SuperUser\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).DisabledUser(\"UnknownUser\")" && \
    iris session iris "##class(dc.irisflow.util.Setup).DisabledUser(\"IAM\")" && \
    # iris session iris "##class(Ens.Config.Credentials).SetCredential(\"telegram-api-key\",\"\",\"$TELEGRAM_APIKEY\")" && \
    # iris session iris "##class(Ens.Config.Credentials).SetCredential(\"climatiq-api-key\",\"\",\"$CLIMATIQ_APIKEY\")" && \
    iris session iris "##class(dc.irisflow.demo.ClimatiqAPIExample01).Create()" && \
    iris session iris "##class(dc.irisflow.demo.ClimatiqAPIExample02).Create()" && \
    # iris session iris "##class(dc.irisflow.util.Setup).AutoStartProduction(\"User.ClimatiqAPIExample02\",0)" && \
    iris session iris "##class(dc.irisflow.util.Setup).CreateContestUser()" && \
    iris stop IRIS quietly

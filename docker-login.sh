#!/bin/bash
secretValue=$(az keyvault secret show --vault-name own-fixed-creds --name dockerhub-login-token --query value --output tsv)
echo $secretValue
docker login -u harriedekorte

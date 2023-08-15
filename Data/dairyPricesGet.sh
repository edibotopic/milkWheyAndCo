#!/bin/sh

curl -v https://ec.europa.eu/agrifood/api/dairy/prices\?products\=wmp,wheypowder\&memberStateCodes\=IE,DE,FR,NL,DK\&years\=2022\&weeks\=5 |
jq -r '["Country", "Product", "Price(€)"],
       (.[] |
           [.memberStateCode, (.product | gsub("WHEYPOWDER"; "WP")), (.price | gsub("€"; "") | tonumber | floor)]) |
       join(",")' > ./dairyPrices/data.csv

echo "Data stored in ./dairyPrices/data.csv"

const express = require('express');
const app = express();

const serverPort = 80;

app.use(express.json());

// start server
app.listen(serverPort, () => {
    console.log("Server running on port " + serverPort);

    // check authentication endpoint
    app.get("/api/checkauth", (req, res, next) => {
        res.json({"valid" : true,"error" : ""});
    });

    // check component endpoint
    app.post("/api/checkcomponent", (req, res, next) => {

        let isSafe = true;
        let currentComponentId = "";

        if(req.body.components){
            for (let i = 0; i < req.body.components.length; i++) {
                currentComponentId = req.body.components[i].component_id;
                if(currentComponentId && currentComponentId.includes("swampup-devsecops")) {
                    console.log("vulnerability found: " + currentComponentId);
                    isSafe = false;
                    break;
                } else {
                    console.log("safe dependency found: " + currentComponentId);
                }
            }
        }

        if(isSafe){
            res.json({"components" : []});
        } else {
            res.json({
                "components" : [
                    {
                        "component_id" : "" + currentComponentId,
                        "licenses" : ["Apache 2.0"],
                        "provider" : "Internal Security Provider",
                        "vulnerabilities" : [
                            {
                                "cve" : "CVE-4242-4242",
                                "type" : "security",
                                "source_id" : "42424242",
                                "summary" : "This component is blacklisted internally",
                                "description" : "Decision was made to get rid of packages using Struts dependency",
                                "cvss_v2" : "8.5",
                                "url" : "http://foo.bar",
                                "publish_date" : "2021-21-01T20:30:00.000+00:00",
                                "references" : [    "http://my.internal.wiki.com/" + currentComponentId + ".html"
                                ]
                            }
                        ]}
                ]
            });
        }
    });

    // Receive webhook endpoint
    app.post("/api/webhook", (req, res, next) => {
        console.log(req.body);
        res.status(200);
    });
});
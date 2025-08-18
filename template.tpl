___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Plausible Analytics",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Template for deploying Plausible Analytics",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "scriptID",
    "displayName": "Script ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "PARAM_TABLE",
    "name": "customProps",
    "displayName": "Custom Properties",
    "paramTableColumns": [
      {
        "param": {
          "type": "SELECT",
          "name": "gtmVariable",
          "displayName": "GTM Variable",
          "macrosInSelect": true,
          "selectItems": [],
          "simpleValueType": true
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "TEXT",
          "name": "plausibleCustomProp",
          "displayName": "Plausible Custom Property",
          "simpleValueType": true,
          "valueValidators": [
            {
              "type": "NON_EMPTY"
            }
          ]
        },
        "isUnique": true
      }
    ],
    "newRowButtonText": "Add Custom Property"
  },
  {
    "type": "GROUP",
    "name": "options",
    "displayName": "Options",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "autoCapturePageviews",
        "checkboxText": "Auto Capture Pageviews",
        "simpleValueType": true,
        "help": "Whether to automatically capture pageviews. Defaults to true.",
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "captureOnLocalhost",
        "checkboxText": "Capture on Localhost",
        "simpleValueType": true,
        "help": "Whether to capture events on localhost. Defaults to false."
      },
      {
        "type": "CHECKBOX",
        "name": "fileDownloads",
        "checkboxText": "File Downloads",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Whether to track file downloads. Defaults to true."
      },
      {
        "type": "CHECKBOX",
        "name": "formSubmissions",
        "checkboxText": "Form Submissions",
        "simpleValueType": true,
        "help": "Whether to track form submissions. Defaults to true.",
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "hashBasedRouting",
        "checkboxText": "Hash Based Routing",
        "simpleValueType": true,
        "help": "Whether the page uses hash based routing. Defaults to false.  Read more at https://plausible.io/docs/hash-based-routing"
      },
      {
        "type": "CHECKBOX",
        "name": "logging",
        "checkboxText": "Logging",
        "simpleValueType": true,
        "help": "Whether to log on ignored events. Defaults to true.",
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "outboundLinks",
        "checkboxText": "Outbound Links",
        "simpleValueType": true,
        "help": "Whether to track outbound link clicks. Defaults to true.",
        "defaultValue": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Sandboxed APIs
const callInWindow = require('callInWindow');
const copyFromWindow = require('copyFromWindow');
const createArgumentsQueue = require('createArgumentsQueue');
const injectScript = require('injectScript');
const log = require('logToConsole');
const parseUrl = require('parseUrl');

const handleSuccess = () => {
  return data.gtmOnSuccess();
};

const handleFail = (msg) => {
  let errorMessage = 'Failed to load Plausible Analytics GTM';
  if (msg) {
    errorMessage = errorMessage + ": " +msg;
  }
  log(errorMessage);
  return data.gtmOnFailure();
};

// Create a queue for plausible calls before the script loads
createArgumentsQueue('plausible', 'plausible.q');

// Check for Script ID
if (!data.scriptID) {
  return handleFail('No Script ID Provided');
}

let scriptID = data.scriptID;

//auto-remove url prefix
if (scriptID && scriptID.indexOf('http') === 0) {
  var url = parseUrl(scriptID);
  log(url);
  if (url.hostname !== 'plausible.io' || url.pathname.indexOf('/js/') !== 0) {
    return handleFail('Invalid Script ID');
  }
  // auto-remove '/js/' from pathname
  scriptID = url.pathname.substring(4);
  // auto-remove leading slash if present
  if (scriptID.length > 0 && scriptID.charAt(0) === '/') {
    scriptID = scriptID.substring(1);
  }
}

// auto-remove .js suffix if present
if (scriptID && scriptID.length > 3 && scriptID.substring(scriptID.length - 3) === '.js') {
  scriptID = scriptID.substring(0, scriptID.length - 3);
}


const scriptSRC = "https://plausible.io/js/" + scriptID + ".js";
const customProps = data.customProps;

const plausibleInit = () => {
  let initProps = {
    autoCapturePageviews: data.autoCapturePageviews,
    captureOnLocalhost: data.captureOnLocalhost,
    fileDownloads: data.fileDownloads,
    formSubmissions: data.formSubmissions,
    hashBasedRouting: data.hashBasedRouting,
    logging: data.logging,
    outboundLinks: data.outboundLinks,
    lib: 'gtm'
  };

  if (customProps && customProps.length > 0) {
    initProps.customProperties = {};

    customProps.forEach(customProp => {
      initProps.customProperties[customProp.plausibleCustomProp] = customProp.gtmVariable;
    });
  }

  callInWindow('plausible.init', initProps);
  return handleSuccess();
};

const plausible = copyFromWindow('plausible');
if (!plausible || plausible.q) {
  // plausible is not loaded, or is still the stub (has .q property)
  injectScript(scriptSRC, plausibleInit, handleFail, 'plausible');
} else {
  // plausible is loaded
  return handleSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://plausible.io/js/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "plausible"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "plausible.init"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "plausible.q"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8/15/2025, 4:08:31 PM



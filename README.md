# How to set up Plausible Analytics using Google Tag Manager

This document walks through how you can set up Plausible Analytics using Google Tag Manager.


## Google Tag Manager Template

In order to make the process easier, we have published a template that makes setting up Plausible Analytics with Google Tag Manager simple and code free. (You can find the source code for the Google Tag Manager template used [here](https://github.com/plausible/plausible-gtm-template))

The simplest way to install the custom template is to locate it in the [Google Tag Manager template gallery](https://tagmanager.google.com/gallery/#/) where you can install it directly from your Google Tag Manager dashboard.

Alternatively, the template can be manually imported with the following steps:
* Download the template.tpl file
* Open a Google Tag Manager Web container inside Google Tag Manager
* In Google Tag Manager browse to the Templates section and in the box titled Tag Templates click the blue New button.
* Once the Template Editor is open, click the menu (three vertical dots) in the top-right corner of the window and choose Import.
* Select the template.tpl file you downloaded previously

Once you’ve installed the template, either manually or through the template gallery, you should create a new Tag that uses it.  To do this:
* In the main Google Tag Manager dashboard, browse to Tags and click New to create a new tag
* From the list of available tag templates, choose the Plausible Analytics tag template you just installed
* Select 'Initialization' as the type
* The only mandatory field in the initial tag configuration is the Script ID that can be found in the Plausible Analytics dashboard under Site Settings > Site Installation > Google Tag Manager (other optional configuration options are described below in the section Tag Configuration)
* For the initial tag trigger, you should select 'All Pages - Page View', which will ensure that Plausible will capture data on all pages


## Tag Configuration

The initialization tag has the following optional configuration options:

| **Optional Configuration** | **Explanation** |
|---------------------------|-----------------|
| **Auto Capture Pageviews**    | Whether to automatically capture pageviews (enabled by default) |
| **Capture on Localhost**      | Whether to capture events on localhost (disabled by default) |
| **File Downloads**            | Automatically [track file downloads](https://plausible.io/docs/file-downloads-tracking) (enabled by default) |
| **Form Submissions**          | Whether to track form submissions (enabled by default) |
| **Hash Based Routing**        | Automatically track page paths that use a `#` in the URL, [described here](https://plausible.io/docs/hash-based-routing) (disabled by default) |
| **Logging**                   | Whether to log on ignored events (enabled by default) |
| **Outbound Links**            | Automatically [track clicks on outbound links](https://plausible.io/docs/outbound-link-click-tracking) (enabled by default) |
| **Custom File Download Types** | Override the default file extensions for tracking file downloads, so only your custom file type downloads will be tracked instead (disabled by default) |
| **404 Tracking**            | Whether to track 404 events using the title of the 404 page (disabled by default) |

## Custom Events

You can also create multiple tags to capture custom events that are linked to different triggers in GTM.  To do this, create a new tag (separate from the initialization tag) and select the 'Custom Event' type. The only mandatory field is 'Event Name' which is the name of the event that will be sent to Plausible.

Optionally, you can configure [revenue tracking](https://plausible.io/docs/ecommerce-revenue-tracking) and add custom properties.

## Custom Properties

Both the Initialization Tag and the Custom Event Tags give you the option to configure one or more [custom properties](https://plausible.io/docs/custom-props/introduction).  In the case of the Initialization Tag, these custom properties will be attached to pageviews, while for Custom Events, they will be attached to that specific event.


## Testing

You can test that everything is working as expected by using Google Tag Manager’s Preview mode.  You can enter Preview mode by clicking the blue Preview button in the Google Tag Manager dashboard. This opens a new tab with your website running the GTM container where you can see if Plausible Analytics is running and capturing data properly. In the Tag Assistant Preview tab, you can see additional information about the events that trigger the tag and the data that is being sent.

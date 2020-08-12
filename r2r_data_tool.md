# R2R Data Tool

## `r2r pack` Workflow
**Example - Files from DA-29, Upload FarePortal data**
Download linked files and convert to TSV, place into fareportal folder
- Add to `Data.Analytics.Raw` → 
    + `r2r pull Data.Analytics.Raw /force`
    + Check the status to ensure that the local is the same as the remote version: `cd Data.Analytics.Raw && r2r status && cd ..`
    + `r2r pack Data.Analytics.Raw` takes local files and adds them into the current package manifest (package.txt)
    + `r2r push Data.Analytics.Raw` → pushes to proxy and then to AWS. You can do `/BypassProxy` to go straight to AWS

## Pull a project

Navigate to project folder (e.g. `rome2rio.web`) then:
Update Web packages and the named packages specified: `r2r pull rome2rio.web /SeoData /Sitemaps /GtfsData`
Bypass the proxy: `r2r pull Data.Analytics.Raw /bypassProxy`
Check the status of the data packages: `cd Data.Analytics.Raw; r2r status`
Pull all of the packages for the project's dependencies: `r2r pull builders\DataAnalyticsBuilder`

## Pulling a specific version
**Question that started the entry**: "_I'm trying to run the LanguageBuilder, it expects that HotelData should be "Amparo" from the 21st but the latest I pulled was a later one called "Cangzhou" from the 23rd. Do you know how I can pull that specific package?_"

This can be done in two ways:

1. **Sync your code**.
```
# Check out the version of the code the builder is running (not sure if this is the right branch name
> git checkout origin/Builders/LanguageBuilder -b Builders/LanguageBuilder
# This should sync code based on the packages required in the given solution.
# (Not sure if this .sln exists ... you can check TFS for which .sln it uses,
# or just use AllProjects which will sync a bunch of other stuff too).
> r2r pull Builders/LanguageBuilder/LanguageBuilder.sln
```
This is probably the "correct" way of doing things as you will have all the correct depenency and code versions.

2. **Just sync the package**

If you type r2r it will give you the help docs -> `r2r pull [package_dir] [/force|/merge] [/n:package_name] [/v:version]`. So, `cd` into the `HotelData` dir and `r2r pull /v:the_version_name`:

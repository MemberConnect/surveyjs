# Wisely instructions
* This repo should be cloned alongside `artemius`
* All development and deploys should be done on the `wisely-dev` branch (or branched off of it). `wisely-dev` should **never** be merged into `master`. `master` should only be used to merge updates from the original `surveyjs` repo, which should in turn be merged into `wisely-dev`. This allows us to branch significantly from the original repo, but still merge in updates as needed.

## To develop locally:
* make changes to source code within this repo
* `npm run wisely_build`
* This will automatically create (or update) `./../survey-vue-build` with built files
* To use these updates locally, use `npm link` e.g. `cd ./../survey-vue-build && npm link && cd ./../artemius && npm link survey-vue`. When done developing locally, run `npm unlink survey-vue` from `./../artemius` root

## To deploy:
* `npm run wisely_deploy`
* This builds the vue files, bumps the prerelease version (so our releases will always be `vX.X.X-Y` where `vX.X.X` is the release from the original SurveyJS that we are currently using), tags it and pushes to the `survey-vue-build` repo
* After changes are deployed, artemius's `package.json` needs to be updated to point the `survey-vue` entry to the new tag to pull down changes

### Why `npm peerDependencies`?
Because this repo only produces built files that will always be used within artemius, we should rely on `artemius` to provide external libraries so that we don't:
1. have duplicate code included
1. have conflicting versions
1. have to track `survey-vue-build/node_modules` in git
1. have to do another `npm install` within `survey-vue-build` when building or when building artemius


#### Original README:

**survey.js** is a JavaScript Survey Library. It is a modern way to add a survey to your website. It uses JSON for survey metadata and results.
[![Build Status](https://travis-ci.org/surveyjs/surveyjs.svg?branch=master)](https://travis-ci.org/surveyjs/surveyjs) [![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE)

![alt tag](https://cloud.githubusercontent.com/assets/22315929/22462339/ed33f60a-e7bd-11e6-942b-72882e6bf1db.gif)

## Getting started
[![Join the chat at https://gitter.im/andrewtelnov/surveyjs](https://badges.gitter.im/andrewtelnov/surveyjs.svg)](https://gitter.im/andrewtelnov/surveyjs?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

To find out more about the library go
* to the [SurveyJS Library Site](https://surveyjs.io/Library)
* explore the live [Examples](https://www.surveyjs.io/Examples/Library)
* and build a survey JSON using [Visual Editor](https://www.surveyjs.io/Editor/Editor/)

You can try plnkr examples at:
* [Angular2](http://plnkr.co/edit/OJkKlUn1oxzWYtnruXir?p=preview) 
* [jQuery](http://plnkr.co/edit/DH4vJWSBtza7bSCDm2r9?p=preview)
* [Knockout](http://plnkr.co/edit/JKy5wwiAhaBTMze3fOO0?p=preview)
* [React](http://plnkr.co/edit/qXdeQa6x2FHRg0YrOlPL?p=preview)
* [Vue](http://plnkr.co/edit/aTYVAiDvMWOf3zDReayE?p=preview)

or use quickstart repos:
* [Angular 2](https://github.com/surveyjs/surveyjs_angular_quickstart)
* [Angular CLI](https://github.com/surveyjs/surveyjs_angular_cli)
* [React](https://github.com/surveyjs/surveyjs_react_quickstart)
* [Vue](https://github.com/surveyjs/surveyjs_vue_quickstart)

Install the library using npm.

Angular2 version:
```
npm install survey-angular
```
jQuery version:
```
npm install survey-jquery
```
Knockout version:
```
npm install survey-knockout
```
React version:
```
npm install survey-react
```
Vue version:
```
npm install survey-vue
```

Or use Azure CDN:
* https://surveyjs.azureedge.net/{version-number}/survey.angular.min.js
* https://surveyjs.azureedge.net/{version-number}/survey.ko.min.js
* https://surveyjs.azureedge.net/{version-number}/survey.react.min.js
* https://surveyjs.azureedge.net/{version-number}/survey.jquery.min.js
* https://surveyjs.azureedge.net/{version-number}/survey.vue.min.js

You find all versions/builds in the [surveyjs/build repo](https://github.com/surveyjs/builds).

Or dowload a version as zip file from [Releases](https://github.com/surveyjs/surveyjs/releases)


## Building survey.js from sources

To build library yourself:

 1. **Clone the repo from GitHub**  
	```
	git clone https://github.com/surveyjs/surveyjs.git
	cd surveyjs
	```

 2. **Acquire build dependencies.** Make sure you have [Node.js](http://nodejs.org/) installed on your workstation. This is only needed to _build_ surveyjs from sources.  
	```
	npm install -g karma-cli
	npm install
	```

 3. **Build the library**
	```
	npm run build_prod
	```
	After that you should have the libraries (angular, jquery, knockout, react and vue) at 'packages' directory.

 4. **Run unit tests**
	```
	karma start
	```
	This command will run unit tests using [Karma](https://karma-runner.github.io/0.13/index.html)

## License

[MIT license](https://github.com/surveyjs/surveyjs/blob/master/LICENSE)


## Visual Editor
Visual Editor [site](https://www.surveyjs.io/Editor/)

Visual Editor sources are [here](https://github.com/surveyjs/editor)

[Try it right now!](https://www.surveyjs.io/Editor/Editor/)

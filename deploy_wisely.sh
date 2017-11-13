cd ..
git clone git@github.com:chriszamierowski/survey-vue-build.git
cd survey-vue-build
cp -a ../surveyjs/packages/survey-vue/. .
git commit -a -m 'building'
git push origin master
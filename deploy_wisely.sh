cd ..
if [ ! -d "survey-vue-build" ]; then
  git clone git@github.com:chriszamierowski/survey-vue-build.git
fi
cd survey-vue-build
cp -a -f ../surveyjs/packages/survey-vue/. .
if [ "$1" = "prod" ]; then
  git add .
  git commit -a -m 'building'
  npm version patch -m "Upgrade to %s"
  git push origin master
fi
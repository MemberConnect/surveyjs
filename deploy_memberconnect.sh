cd ..
if [ ! -d "survey-vue-build" ]; then
  git clone git@github.com:MemberConnect/survey-vue-build.git
fi
cd survey-vue-build
cp -a -f ../surveyjs/packages/survey-vue/. .
if [ "$1" = "prod" ]; then
  VERSION=$(node -pe "'v' + require('./package.json').version")
  git add .
  git commit -a -m "Upgrade to ${VERSION}"
  git tag "${VERSION}"
  git push origin master --tags
fi
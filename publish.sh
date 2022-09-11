git clone git@github.com:getparthenon/getparthenon.com.git ../getparthenon.com

cp -R docs ../getparthenon.com
cp -R version_docs ../getparthenon.com

cd ../getparthenon.com

if [ -z "$(git status --porcelain)" ]; then
  echo "No changes found"
else
  echo "Pushing update to repository"
  git commit -am "$COMMIT_MESSAGE


Automatic commit for https://github.com/getparthenon/parthenon-docs/commit/$GITHUB_SHA"
  git push origin $BRANCH
fi

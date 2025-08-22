git add $draft

git commit -m "docs(readme): proposed README (no main changes)"

git push -u origin HEAD

gh pr create -B main -t "README refresh (draft)" -b "Proposed main README. Review via CODEOWNERS. No change to main." --draft




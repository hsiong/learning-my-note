





# Linking a pull request to an issue
***Reference***
+ https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword

When you merge a linked pull request into the default branch of a repository, its linked issue is automatically closed. For more information about the default branch, see "Changing the default branch."

## Linking a pull request to an issue using a keyword

You can link a pull request to an issue by using a supported keyword in the pull request's <u>description or in a commit message</u>. The pull request **must be on the default branch**.

+ close
+ closes
+ closed
+ fix
+ fixes
+ fixed
+ resolve
+ resolves
+ resolved

If you use a keyword to reference a pull request comment in another pull request, the pull requests will be linked. Merging the referencing pull request also closes the referenced pull request.
  
The syntax for closing keywords depends on whether the issue is in the same repository as the pull request.

<table>
<ul>

<tr>
<td>Linked issue</td>
<td>Syntax</td>
<td>Example</td>
</tr>

<tr>
<td>Issue in the same repository</td>
<td>KEYWORD #ISSUE-NUMBER	</td>
<td>Closes #10</td>
</tr>

<tr>
<td>Issue in a different repository</td>
<td>KEYWORD OWNER/REPOSITORY#ISSUE-NUMBER</td>
<td>Fixes octo-org/octo-repo#100</td>
</tr>

<tr>
<td>Multiple issues	</td>
<td>Use full syntax for each issue	</td>
<td>Resolves #10, resolves #123, resolves octo-org/octo-repo#100</td>
</tr>

</ul>
</table>

Only manually linked pull requests can be manually unlinked. To unlink an issue that you linked using a keyword, you must edit the pull request description to remove the keyword.

You can also use closing keywords in a commit message. The issue will be closed when you merge the commit into the default branch, but the pull request that contains the commit will not be listed as a linked pull request.

## Manually linking a pull request to an issue
Anyone with write permissions to a repository can manually link a pull request to an issue.

You can manually link up to ten issues to each pull request. The issue and pull request must be in the same repository.


# Normally the workflow to fix a bug/issue on github project

***Reference***  
https://stackoverflow.com/questions/18393157/assigning-issues-to-yourself-on-github

1. fork a repo
2. create a new branch
3. fix the bug in the new branch
4. create a pull request from your branch to upstream project, when you can reference the original issue

























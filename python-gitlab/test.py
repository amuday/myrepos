import gitlab
import json

gl = gitlab.Gitlab(url='https://gitlab.com', private_token='glpat-LNZV9Fx1yyeJ5bAczK57')

# list all the projects
projects = gl.projects.list()
for project in projects:
    print(project.id)
    j=project.to_json()
    rsj=json.loads(j)
    print(rsj["id"])
    print(project.to_json())


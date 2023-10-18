import gitlab

#gl = gitlab.Gitlab(url='https://gitlab.com/pipeline-types', private_token='glpat-Xqq3sex1puZG84zG7CaF')

#gl = gitlab.Gitlab(private_token='glpat-Xqq3sex1puZG84zG7CaF')

gl = gitlab.Gitlab('https://gitlab.com/pipeline-types', oauth_token='glpat-zo8P5snK-Jqm9fPuds1P')

# list all the projects
projects = gl.projects.list(iterator=True)
for project in projects:
    print(project)
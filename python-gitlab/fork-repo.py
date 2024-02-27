import gitlab
import config

## https://python-gitlab.readthedocs.io/en/stable/api-usage.html ************

gl = gitlab.Gitlab(url='https://gitlab.com', private_token=config.token)

# List owned projects. commented the code, it will fetch only 20 projects
# projects = gl.projects.list(owned=True)
# print(projects)

project_ids = open("project_ids.txt", "r").readlines()

print(project_ids)

for project_id in project_ids:        

    project = gl.projects.get(project_id)
    #print(project)
    print(project.http_url_to_repo)
    print(project.web_url)
    fork = project.forks.create({'namespace': 'gitlab-api3'})

    #print(fork)

    forked_project_id = fork.id
    forked_project = gl.projects.get(fork.id)

    forked_project.delete_fork_relation()


    # create push mirror
    mirror = forked_project.remote_mirrors.create({'url': project.http_url_to_repo , 'enabled': True})
   

    print("https://gitlab.com/api/v4/projects/" + str(forked_project_id))

    response=gl.http_put(
        path="https://gitlab.com/api/v4/projects/"+ str(forked_project_id)  ,
        post_data ={
                    "mirror": "true",
                    "import_url": "https://udayavula:" + config.token +"@gitlab.com/pipeline-types/project-1.git"
            })

    print(response)

    mirror = project.mirror_pull()

   
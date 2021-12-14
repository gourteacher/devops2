---
- hosts:  servers
  become: true
  vars:
    project_location: /srv/long_running_python_process
    program_name: long_running_process

  tasks:


    - name: restart supervisord
      service: name=supervisord state=restarted

    - name: "supervisorctl restart {{program_name}}"
      command: "supervisorctl restart {{program_name}}"
[program:{{ program_name }}]
command=sh run.sh
autostart=true
directory={{ project_location }}
stderr_logfile=/var/log/{{ program_name }}.err.log
stdout_logfile=/var/log/{{ program_name }}.out.log

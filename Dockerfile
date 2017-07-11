FROM ansible-tower:3.1.1

# TODO: add python libraries
ENV PYTHONNOUSERSITE True

ENV ANSIBLE_LIBRARY /opt/oneview-ansible/library

RUN . /var/lib/awx/venv/ansible/bin/activate &&\
	pip install git+https://github.com/HewlettPackard/python-hpOneView.git && \ 
	pip install hpICsp 

RUN git clone --branch v3.1.1 https://github.com/HewlettPackard/oneview-ansible.git /opt/oneview-ansible

#RUN echo $ANSIBLE_LIBRARY > /var/lib/awx/venv/ansible/local/lib/python2.7/site-packages/ansible_library.pth

RUN echo AWX_TASK_ENV[\'ANSIBLE_LIBRARY\']=\'$ANSIBLE_LIBRARY\' >> /etc/tower/settings.py

RUN echo AWX_TASK_ENV[\'PYTHONPATH\']=\'/usr/lib/python2.7/dist-packages/awx/lib:/var/lib/awx/venv/ansible/lib/python2.7/site-packages:$ANSIBLE_LIBRARY:\'  >> /etc/tower/settings.py

COPY userstart /userstart
RUN chmod +x ./userstart
class profile::wordpress { 

docker::run { 'helloworld':
  image   => 'ubuntu:precise',
  command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
  volumes => ['my-volume:/var/log'],
}

}

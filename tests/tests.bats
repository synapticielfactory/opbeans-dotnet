#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load test_helpers

IMAGE="bats-opbeans"
CONTAINER="bats-opbeans"

@test "build image" {
	cd $BATS_TEST_DIRNAME/..
	docker build -t $IMAGE .
}

@test "clean test containers" {
	cleanup $CONTAINER
}

@test "create test container" {
	run docker run -d --name $CONTAINER -P $IMAGE
	assert_success
}

@test "test container is running" {
	sleep 1
	run docker inspect -f {{.State.Running}} $CONTAINER
	assert_output --partial 'true'
}

@test "opbeans is running in port ${PORT}" {
	sleep 20
	URL="http://localhost:$(docker port "$CONTAINER" ${PORT} | cut -d: -f2)"
	run curl -v --fail --connect-timeout 10 --max-time 30 "$URL/"
	assert_success
	assert_output --partial 'HTTP/1.1 200 OK'
}

@test "clean test containers" {
	cleanup $CONTAINER
}

#!/bin/sh

HOST="${HOST:-http://localhost:3000}"

echo testing against $HOST

if [ "$HOST" = "http://localhost:3000" ]; then
    echo killing process on port 3000
    kill $(lsof -t -i:3000) || true
    while [[ -n $(lsof -t -i:3000) ]]; do
        echo waiting kill
        sleep 1
    done

    PORT=3000 npm run start -- --hostname=localhost &
fi

until $(curl --output /dev/null --head --fail -k $HOST); do

    sleep 5
    echo server is unreachable

done

if [ -z "$CI" ]; then

    echo detected non-ci environment
    PLAYWRIGHT_SLOW_MO=0

fi

cleanup() {
    if [ "$HOST" = "http://localhost:3000" ]; then
        echo killing process on port 3000
        kill $(lsof -t -i:3000)
    fi
}

echo testing api
TEST_HOST=$HOST npx playwright@^1.26.0 test ./api-tests --project=chromium || {
    cleanup
    echo 'test failed'
    exit 1
}

echo testing with browser
TEST_HOST=$HOST PLAYWRIGHT_SLOW_MO=$PLAYWRIGHT_SLOW_MO npx playwright@^1.26.0 test ./e2e-tests || {
    cleanup
    echo 'test failed'
    exit 1
}

cleanup


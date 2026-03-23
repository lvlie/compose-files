#!/bin/bash
# tests/test-validate-docker-compose.sh

# Get the absolute path of the script under test
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALIDATE_SCRIPT="$(cd "$SCRIPT_DIR/../scripts" && pwd)/validate-docker-compose.sh"

# Create a temporary directory for tests
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Mocking docker-compose
MOCK_BIN_DIR="$TEMP_DIR/bin"
mkdir -p "$MOCK_BIN_DIR"
export PATH="$MOCK_BIN_DIR:$PATH"

# Test helper: Create a dummy docker-compose mock
create_mock_docker_compose() {
    local exit_code=$1
    cat <<EOF > "$MOCK_BIN_DIR/docker-compose"
#!/bin/bash
exit $exit_code
EOF
    chmod +x "$MOCK_BIN_DIR/docker-compose"
}

# Test helper: Run the validation script and check exit code
run_test() {
    local compose_file=$1
    local expected_exit_code=$2
    local test_name=$3

    set +e
    bash "$VALIDATE_SCRIPT" "$compose_file" > /dev/null 2>&1
    local actual_exit_code=$?
    set -e

    if [ "$actual_exit_code" -eq "$expected_exit_code" ]; then
        echo "PASS: $test_name"
    else
        echo "FAIL: $test_name (Expected $expected_exit_code, got $actual_exit_code)"
        exit 1
    fi
}

echo "Running tests for validate-docker-compose.sh..."

# Case 1: Success - Valid Docker Compose file and docker-compose exists
create_mock_docker_compose 0
touch "$TEMP_DIR/docker-compose.yml"
run_test "$TEMP_DIR/docker-compose.yml" 0 "Valid file and docker-compose exists"

# Case 2: Failure - Invalid Docker Compose file (docker-compose returns non-zero)
create_mock_docker_compose 1
run_test "$TEMP_DIR/docker-compose.yml" 1 "Invalid file (docker-compose returns 1)"

# Case 3: Failure - docker-compose command is missing
rm "$MOCK_BIN_DIR/docker-compose"
run_test "$TEMP_DIR/docker-compose.yml" 1 "docker-compose missing"

# Case 4: Failure - Provided file does not exist
create_mock_docker_compose 0
run_test "$TEMP_DIR/non-existent.yml" 1 "File does not exist"

echo "All tests passed!"

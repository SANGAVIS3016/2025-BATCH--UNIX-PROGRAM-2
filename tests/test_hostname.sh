#!/bin/bash

echo "======================================"
echo "   HOSTNAME PRACTICAL AUTOGRADER"
echo "======================================"

PASS=0
FAIL=0

pass_test()
{
    echo "PASS: $1"
    PASS=$((PASS + 1))
}

fail_test()
{
    echo "FAIL: $1"
    FAIL=$((FAIL + 1))
}

# Check whether hostname.sh exists

if [ -f hostname.sh ]; then
    pass_test "hostname.sh file exists"
else
    fail_test "hostname.sh file is missing"
    exit 1
fi


# Test 1: Bash syntax

if bash -n hostname.sh; then
    pass_test "Bash syntax is correct"
else
    fail_test "Bash syntax is incorrect"
fi


# Test 2: hostnamectl command

if grep -q "hostnamectl" hostname.sh; then
    pass_test "hostnamectl command is used"
else
    fail_test "hostnamectl command is missing"
fi


# Test 3: set-hostname command

if grep -Eq "hostnamectl[[:space:]]+set-hostname[[:space:]]+rvs" hostname.sh; then
    pass_test "Hostname is changed to rvs"
else
    fail_test "hostnamectl set-hostname rvs is missing"
fi


# Test 4: exec bash

if grep -Eq "exec[[:space:]]+bash" hostname.sh; then
    pass_test "exec bash command is used"
else
    fail_test "exec bash command is missing"
fi


# Test 5: Safe execution

MOCK_DIR=$(mktemp -d)

cat > "$MOCK_DIR/hostnamectl" <<'EOF'
#!/bin/bash

echo "$@" >> /tmp/hostnamectl.log

if [ "$1" = "set-hostname" ] && [ "$2" = "rvs" ]; then
    echo "Hostname successfully changed to rvs"
    exit 0
fi

echo "Static hostname: student-test"
exit 0
EOF

chmod +x "$MOCK_DIR/hostnamectl"

rm -f /tmp/hostnamectl.log

if timeout 10 bash -c "PATH=$MOCK_DIR:\$PATH bash hostname.sh" \
    </dev/null >/tmp/student_output 2>/tmp/student_error
then
    pass_test "Student program executed successfully"
else
    fail_test "Student program execution failed"
fi


# Test 6: Check actual command requested

if grep -q "set-hostname rvs" /tmp/hostnamectl.log 2>/dev/null; then
    pass_test "Autograder detected hostname change to rvs"
else
    fail_test "Hostname change was not detected"
fi


rm -rf "$MOCK_DIR"


echo
echo "======================================"
echo "             FINAL RESULT"
echo "======================================"

echo "Tests Passed : $PASS"
echo "Tests Failed : $FAIL"

if [ "$FAIL" -eq 0 ]; then
    echo "RESULT: PASS"
    exit 0
else
    echo "RESULT: FAIL"
    exit 1
fi

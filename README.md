# Web-automation assignment

I'm using robotframeworks to finish the assignment.

## setting up the environment

1. Clone the project
2. `cd` into the folder
3. Set up virtual environment with following command

    ```shell
    python -m venv .venv
    ```

4. Run the following command to activate the virtual environment

    ```shell
    source .venv/bin/activate
    ```

5. Run the follwing command to install the dependencies

    ```shell
    pip install -r requirements.txt
    ```

    And check if the environment is ready by

    ```shell
    robot --version
    ```

6. Run all the testcases

    ```shell
    robot testcases
    ```

    And you should be able to see the result htmls.

"""
This module formats the HTML body of the email
"""
def format_email(pass_count: str, fail_count: str, skipped_count: str, link: str) -> str:
    """
    This function formats the HTML body of the email
    """
    return f"""
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body {{
                font-family: Arial, sans-serif;
                margin: 20px;
            }}
            table {{
                width: 50%;
                border-collapse: collapse;
                margin: 20px 0;
            }}
            table, th, td {{
                border: 1px solid #dddddd;
            }}
            th, td {{
                padding: 8px;
                text-align: left;
            }}
            th {{
                background-color: #f2f2f2;
            }}
            .pass {{
                background-color: #d4edda;
                color: #155724;
            }}
            .fail {{
                background-color: #f8d7da;
                color: #721c24;
            }}
            .skipped {{
                background-color: #fff3cd;
                color: #856404;
            }}
        </style>
    </head>
    <body>

    <h2>Latest Test Results Summary</h2>
    <p>Here is the summary of the latest test results:</p>

    <table>
        <tr>
            <th style="width: 70%;">Status</th>
            <th style="width: 30%;">Count</th>
        </tr>
        <tr>
            <td class="pass">Pass</td>
            <td>{pass_count}</td>
        </tr>
        <tr>
            <td class="fail">Fail</td>
            <td>{fail_count}</td>
        </tr>
        <tr>
            <td class="skipped">Skipped</td>
            <td>{skipped_count}</td>
        </tr>
    </table>
    <a href="{link}">Click here</a> to see the latest job execution page<br>
    </body>
    </html>
    """

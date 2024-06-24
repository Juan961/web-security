package models

// Prompt: Podías darme una estructura de Go donde pueda hacer unmarshal de este json, response de GitHub Webhook

const REGION = "us-east-2"

type GitHubWebhook struct {
	Repository Repository `json:"repository"`
	HeadCommit Commit     `json:"head_commit"`
}

type Repository struct {
	FullName string `json:"full_name"`
}

type Commit struct {
	ID      string     `json:"id"`
	Message string     `json:"message"`
	Author  CommitUser `json:"author"`
}

type CommitUser struct {
	Email    string `json:"email"`
	Username string `json:"username"`
}

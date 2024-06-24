package main

import (
	"context"
	"encoding/json"
	"testing"
	"time"

	"github-tracker/github-tracker/models"
	"github-tracker/github-tracker/repository"
	"github-tracker/github-tracker/repository/entity"

	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/require"
)

func TestDummy(t *testing.T) {
	c := require.New(t)

	result := 22

	c.Equal(22, result)
}

func TestInsert(t *testing.T) {
	c := require.New(t)

	webhook := models.GitHubWebhook{
		Repository: models.Repository{
			FullName: "Juan961/web-security",
		},
		HeadCommit: models.Commit{
			ID:      "c076ba848dfbea72c4d6fc437bef975de8c5c553",
			Message: "Add sample main.go router",
			Author: models.CommitUser{
				Email:    "juanjo5792@gmail.com",
				Username: "Juan961",
			},
		},
	}

	body, err := json.Marshal(webhook)

	c.NoError(err) // Validar que no existan errores

	createdTime := time.Now()

	m := mock.Mock{}

	mockCommit := repository.MockCommit{Mock: &m}

	commit := entity.Commit{
		RepoName:       webhook.Repository.FullName,
		CommitID:       webhook.HeadCommit.ID,
		CommitMessage:  webhook.HeadCommit.Message,
		AuthorUsername: webhook.HeadCommit.Author.Username,
		AuthorEmail:    webhook.HeadCommit.Author.Email,
		Payload:        string(body),
		CreatedAt:      createdTime,
		UpdatedAt:      createdTime,
	}

	ctx := context.Background()

	mockCommit.On("Insert", ctx, &commit).Return(nil) // Decimos que se inserto todo bien

	err = insertGitHubWebhook(ctx, mockCommit, webhook, string(body), createdTime)

	c.NoError(err)

	m.AssertExpectations(t)
}

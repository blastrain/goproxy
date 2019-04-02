package auth

import (
	"fmt"
	"net/url"
)

var BasicAuthToken string

func FilterRepo(repo string) string {
	if BasicAuthToken == "" {
		return repo
	}
	u, err := url.Parse(repo)
	if err != nil {
		// if got error, ignore filter process
		return repo
	}
	return fmt.Sprintf("%s://%s:x-oauth-basic@%s%s", u.Scheme, BasicAuthToken, u.Host, u.Path)
}

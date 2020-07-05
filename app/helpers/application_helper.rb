# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'suruga-bu(駿河部)',
      title: '静岡県(東部)の紹介メディア',
      reverse: true,
      charset: 'utf-8',
      description: '静岡県(東部)の紹介メディア。沼津市,三島市,富士市,伊豆等の地元スポットの紹介サイトです。',
      keywords: '観光,公園,グルメ,伊豆,沼津,三島,富士,静岡県東部',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('/assets/maguro.svg') }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('/assets/maguro.svg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary',
        site: '@BuSuruga',
        image: image_url('/assets/maguro.svg'),
        width: 100,
        height: 100
      }
    }
  end
end

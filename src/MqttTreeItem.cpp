#include <QStringList>

#include "MqttTreeItem.h"

MqttTreeItem::MqttTreeItem(const QList<QVariant> &data, MqttTreeItem *parent)
{
    m_parentItem = parent;
    m_itemData = data;
}

MqttTreeItem::~MqttTreeItem()
{
    qDeleteAll(m_childItems);
}

void MqttTreeItem::appendChild(MqttTreeItem *item)
{
    m_childItems.append(item);
}

MqttTreeItem *MqttTreeItem::child(int row)
{
    return m_childItems.value(row);
}

int MqttTreeItem::childCount() const
{
    return m_childItems.count();
}

int MqttTreeItem::columnCount() const
{
    return m_itemData.count();
}

QVariant MqttTreeItem::data(int column) const
{
    return m_itemData.value(column);
}

MqttTreeItem *MqttTreeItem::parentItem()
{
    return m_parentItem;
}

int MqttTreeItem::row() const
{
    if (m_parentItem)
        return m_parentItem->m_childItems.indexOf(const_cast<MqttTreeItem*>(this));

    return 0;
}

void MqttTreeItem::removeAll()
{
    m_childItems.clear();
}
